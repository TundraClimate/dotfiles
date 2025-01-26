return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    config = function()
      local nvim_lsp = require("lspconfig")

      local on_attach = function(_, bufnr)
        local function buf_set_keymap(...)
          vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        local function buf_set_option(k, v)
          vim.api.nvim_set_option_value(k, v, { buf = bufnr })
        end

        --Enable completion triggered by <c-x><c-o>
        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        local opts = { noremap = true, silent = true }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        --buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts) -- 宣言元に飛ぶやつ
        buf_set_keymap("n", "<leader>j", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts) -- 定義元に飛ぶやつ (１つ上と合わせてCTRL-クリックでいける)
        buf_set_keymap("n", "<A-enter>", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
        --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts) -- 実装されてるリストを表示するやつ (grepでいい)
        --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts) -- カーソル下のシグネチャー表示(よく分からん)
        --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts) -- ここから
        --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts) -- ここまでワークスペースを弄る(neotree)
        --buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts) -- 型宣言元に飛ぶやつ
        buf_set_keymap("n", "<leader>RR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        --buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts) -- コードアクションを実行するらしい
        --buf_set_keymap('n', '<A-r>', '<cmd>lua vim.lsp.buf.references()<CR>', opts) -- 参照のリストを表示するやつ
        --buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts) -- エラーとかのなんか？
        --buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        --buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        --buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts) -- よく分からんけどほぼ関係ない
        buf_set_keymap("n", "<C-s>", "<cmd>lua vim.lsp.buf.format()<CR><cmd>w<CR>", opts)
      end

      nvim_lsp.rust_analyzer.setup({
        on_attach = on_attach,
      })

      nvim_lsp.omnisharp.setup({
        on_attach = on_attach,
      })

      nvim_lsp.lua_ls.setup({
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
          },
        },
      })

      nvim_lsp.ts_ls.setup({
        on_attach = on_attach,
      })

      nvim_lsp.eslint.setup({
        on_attach = on_attach,
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local nls = require("null-ls")

      nls.setup({
        sources = {
          nls.builtins.code_actions.textlint,
          nls.builtins.completion.spell,
          nls.builtins.completion.tags,
          nls.builtins.diagnostics.hadolint,
          nls.builtins.formatting.csharpier,
          nls.builtins.formatting.stylua,
        },
      })
    end,
  },
}
