local fs = vim.fs

local group = vim.api.nvim_create_augroup("roslyn_ls", {
    clear = true,
})

local function open_solution(client, solution)
    client:notify("solution/open", {
        solution = vim.uri_from_fname(solution),
    })
end

local function open_projects(client, projects)
    client:notify("project/open", {
        projects = vim.tbl_map(function(project)
            return vim.uri_from_fname(project)
        end, projects),
    })
end

local function refresh_diagnostics(client)
    local capabilities = vim.iter(client.dynamic_capabilities.capabilities.diagnosticProvider or {})
        :map(function(cap)
            return cap.registerOptions.identifier
        end)
        :totable()

    for bufnr, _ in pairs(client.attached_buffers) do
        if vim.api.nvim_buf_is_loaded(bufnr) then
            for _, identifier in ipairs(capabilities) do
                client:request(vim.lsp.protocol.Methods.textDocument_diagnostic, {
                    identifier = identifier,

                    textDocument = vim.lsp.util.make_text_document_params(bufnr),
                }, nil, bufnr)
            end
        end
    end
end

local function handlers()
    return {
        ["workspace/projectInitializationComplete"] = function(_, _, ctx)
            local client = assert(vim.lsp.get_client_by_id(ctx.client_id))

            refresh_diagnostics(client)

            return vim.NIL
        end,

        ["razor/provideDynamicFileInfo"] = function()
            return vim.NIL
        end,
    }
end

local function apply_action(client, action)
    if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
    end

    if action.command then
        client:exec_cmd(action.command)
    end
end

local function handle_fix_all_action(client, command, bufnr)
    local arg = command.arguments and command.arguments[1]

    if type(arg) ~= "table" then
        return
    end

    local flavors = arg.FixAllFlavors

    if type(flavors) ~= "table" or vim.tbl_isempty(flavors) then
        return
    end

    vim.ui.select(flavors, {
        prompt = "Fix All Scope:",
    }, function(scope)
        if not scope then
            return
        end

        client:request("codeAction/resolveFixAll", {
            title = command.title,
            data = arg,
            scope = scope,
        }, function(err, resolved)
            if err then
                return
            end

            if resolved then
                apply_action(client, resolved)
            end
        end, bufnr)
    end)
end

local commands = {
    ["roslyn.client.completionComplexEdit"] = function(command, ctx)
        local client = assert(vim.lsp.get_client_by_id(ctx.client_id))

        local args = command.arguments or {}

        local uri = args[1]
        local edit = args[2]

        if uri and edit and edit.newText and edit.range then
            local workspace_edit = {
                changes = {
                    [uri.uri] = {
                        {
                            range = edit.range,
                            newText = edit.newText,
                        },
                    },
                },
            }

            vim.lsp.util.apply_workspace_edit(workspace_edit, client.offset_encoding)
        else
        end
    end,

    ["roslyn.client.nestedCodeAction"] = function(command, ctx)
        local client = assert(vim.lsp.get_client_by_id(ctx.client_id))

        local arg = command.arguments and command.arguments[1]

        if type(arg) ~= "table" then
            return
        end

        local function handle(action)
            if not action then
                return
            end

            if action.data and not action.edit and not action.command then
                client:request("codeAction/resolve", action, function(err, resolved)
                    if err then
                        return
                    end

                    if resolved then
                        handle(resolved)
                    end
                end, ctx.bufnr)

                return
            end

            local nested

            if vim.islist(action) then
                nested = action
            else
                nested = action.NestedCodeActions
            end

            if type(nested) ~= "table" or vim.tbl_isempty(nested) then
                apply_action(client, action)
                return
            end

            if #nested == 1 then
                handle(nested[1])
                return
            end

            vim.ui.select(nested, {
                prompt = action.title or "Select code action",

                format_item = function(item)
                    return item.title or (item.command and item.command.title) or "Unnamed action"
                end,
            }, function(choice)
                if choice then
                    handle(choice)
                end
            end)
        end

        handle(arg)
    end,

    ["roslyn.client.fixAllCodeAction"] = function(command, ctx)
        local client = assert(vim.lsp.get_client_by_id(ctx.client_id))

        handle_fix_all_action(client, command, ctx.bufnr)
    end,
}

return {
    cmd = { "roslyn-language-server", "--stdio" },
    filetypes = { "cs" },

    handlers = handlers(),

    commands = commands,

    on_init = {
        function(client)
            local root = client.config.root_dir

            if not root then
                return
            end

            for entry, type in fs.dir(root) do
                if type == "file" and (vim.endswith(entry, ".sln") or vim.endswith(entry, ".slnx")) then
                    open_solution(client, fs.joinpath(root, entry))

                    return
                end
            end

            local projects = {}

            for entry, type in fs.dir(root) do
                if type == "file" and vim.endswith(entry, ".csproj") then
                    table.insert(projects, fs.joinpath(root, entry))
                end
            end

            if #projects > 0 then
                open_projects(client, projects)
            else
            end
        end,
    },
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
            group = group,
            buffer = bufnr,

            callback = function()
                refresh_diagnostics(client)
            end,

            desc = "roslyn_ls: refresh diagnostics",
        })
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        local opts = { noremap = true, silent = true }

        buf_set_keymap("n", "<leader>j", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
        buf_set_keymap("n", "<A-enter>", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
        buf_set_keymap("n", "<leader>RR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        buf_set_keymap("n", "<C-s>", "<cmd>lua vim.lsp.buf.format()<CR><cmd>w<CR>", opts)
    end,

    capabilities = {
        textDocument = {
            diagnostic = {
                dynamicRegistration = true,
            },
        },
    },

    root_dir = function(bufnr, on_dir)
        local root = vim.fs.root(bufnr, {
            "*.sln",
            "*.slnx",
            "*.csproj",
            ".git",
        })

        if root then
            on_dir(root)
        end
    end,

    settings = {
        ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "fullSolution",
            dotnet_compiler_diagnostics_scope = "fullSolution",
        },

        ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,

            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,

            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
        },

        ["csharp|symbol_search"] = {
            dotnet_search_reference_assemblies = true,
        },

        ["csharp|completion"] = {
            dotnet_show_name_completion_suggestions = true,
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_provide_regex_completions = true,
        },

        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
        },
    },
}
