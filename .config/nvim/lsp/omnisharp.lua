return {
    cmd = { "OmniSharp", "-hpid", tostring(vim.fn.getpid()), "-lsp" },
    filetypes = { "cs" },
    settings = {},
    on_attach = function(_, bufnr)
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        local opts = { noremap = true, silent = true }

        buf_set_keymap("n", "<leader>j", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
        buf_set_keymap("n", "<A-enter>", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
        buf_set_keymap("n", "<leader>RR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        buf_set_keymap("n", "<C-s>", "<cmd>lua vim.lsp.buf.format()<CR><cmd>w<CR>", opts)
    end,
}
