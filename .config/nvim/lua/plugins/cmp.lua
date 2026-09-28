return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
    },

    opts = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")

        local border_opts = {
            border = "single",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }

        return {
            matching = {
                disallow_partial_matching = true,
                disallow_fuzzy_matching = true,
            },

            sorting = {
                comparators = {
                    function(entry1, entry2)
                        if entry1.source.name ~= "nvim_lsp" or entry2.source.name ~= "nvim_lsp" then
                            return nil
                        end

                        local variable = vim.lsp.protocol.CompletionItemKind.Variable

                        local kind1 = entry1.completion_item.kind
                        local kind2 = entry2.completion_item.kind

                        if kind1 == variable and kind2 ~= variable then
                            return true
                        end

                        if kind2 == variable and kind1 ~= variable then
                            return false
                        end

                        return nil
                    end,
                    function(entry1, entry2)
                        local line = vim.api.nvim_get_current_line()
                        local col = vim.api.nvim_win_get_cursor(0)[2]

                        local before_cursor = line:sub(1, col)

                        local prefix = before_cursor:match("[%w_]+$") or ""

                        if prefix == "" then
                            return nil
                        end

                        local label1 = entry1.completion_item.label or ""
                        local label2 = entry2.completion_item.label or ""

                        local match1 = vim.startswith(label1, prefix)
                        local match2 = vim.startswith(label2, prefix)

                        if match1 and not match2 then
                            return true
                        end

                        if match2 and not match1 then
                            return false
                        end

                        return nil
                    end,
                    function(entry1, entry2)
                        local lsp1 = entry1.source.name == "nvim_lsp"
                        local lsp2 = entry2.source.name == "nvim_lsp"

                        if lsp1 and not lsp2 then
                            return true
                        end

                        if lsp2 and not lsp1 then
                            return false
                        end

                        return nil
                    end,
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },

            preselect = cmp.PreselectMode.None,
            formatting = {
                format = lspkind.cmp_format({
                    mode = "text",
                    maxwidth = {
                        menu = 50,
                        abbr = 50,
                    },

                    ellipsis_char = "...",
                    show_labelDetails = true,
                }),
            },

            window = {
                completion = cmp.config.window.bordered(border_opts),
                documentation = cmp.config.window.bordered(border_opts),
            },

            mapping = cmp.mapping.preset.insert({
                ["<tab>"] = cmp.mapping.select_next_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),

            sources = cmp.config.sources({
                {
                    name = "nvim_lsp",
                    entry_filter = function(entry)
                        local lsp_kinds = require("cmp.types").lsp.CompletionItemKind
                        return entry:get_kind() ~= lsp_kinds.Text and entry:get_kind() ~= lsp_kinds.Snippet
                    end,
                },
                { name = "nvim_lua" },
                { name = "buffer" },
                { name = "path" },
            }),
        }
    end,
}
