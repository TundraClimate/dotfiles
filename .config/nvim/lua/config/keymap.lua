local keymap = vim.keymap.set

keymap("i", "jj", "<esc>")
keymap("i", "ｊｊ", "<esc>")
keymap("i", "JJ", "<esc>")

keymap("n", "j", "gj")
keymap("n", "H", "10h")
keymap("n", "J", "10gj")
keymap("n", "K", "10k")
keymap("n", "L", "10l")
keymap("n", "<right>", "<cmd>bprevious<cr>")
keymap("n", "<up>", function()
  vim.api.nvim_buf_delete(0, { force = true })
end)
keymap("n", "<C-e><C-e>", "f{a<enter><esc>ko")
keymap("n", "??", "f;i?<esc>")
keymap("n", "<C-s>", "<cmd>w<cr>")

local telescope = require("telescope.builtin")

keymap("n", "<leader>ff", telescope.find_files, {})
keymap("n", "<leader>fg", telescope.live_grep, {})
keymap("n", "<leader>fb", telescope.buffers, {})
keymap("n", "<leader>fc", telescope.current_buffer_fuzzy_find, {})
keymap("n", "<leader>fr", telescope.lsp_references, {})
keymap("n", "<leader>gc", telescope.git_commits, {})
keymap("n", "<leader>gt", telescope.git_status, {})
