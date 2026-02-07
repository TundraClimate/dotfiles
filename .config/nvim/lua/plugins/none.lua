return {
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = false,
        config = function()
            local nls = require("null-ls")

            nls.setup({
                sources = {
                    nls.builtins.code_actions.textlint,
                    nls.builtins.completion.spell,
                    nls.builtins.completion.tags,
                    nls.builtins.diagnostics.hadolint,
                    nls.builtins.formatting.prettier,
                    nls.builtins.formatting.csharpier,
                    nls.builtins.formatting.stylua,
                    nls.builtins.formatting.shfmt,
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            })
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        opts = {
            ensure_installed = { "textlint", "hadolint", "prettier", "csharpier", "stylua", "shfmt" },
        },
    },
}
