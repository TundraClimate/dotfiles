local keymap = vim.keymap.set

keymap('i', 'jj', '<esc>')
keymap('i', 'ｊｊ', '<esc>')
keymap('i', 'JJ', '<esc>')

keymap('n', "j", "gj")
keymap('n', 'H', '10h')
keymap('n', 'J', '10gj')
keymap('n', 'K', '10k')
keymap('n', 'L', '10l')
keymap('n', '<right>', '<cmd>bNext<cr>')
keymap('n', '<up>', function() vim.api.nvim_buf_delete(0, { force = true }) end)

local telescope = require("telescope.builtin")

keymap('n', '<leader>ff', telescope.find_files, {})
keymap('n', '<leader>fg', telescope.live_grep, {})
keymap('n', '<leader>fb', telescope.buffers, {})
keymap('n', '<leader>fc', telescope.current_buffer_fuzzy_find, {})
keymap('n', '<leader>fr', telescope.lsp_references, {})
