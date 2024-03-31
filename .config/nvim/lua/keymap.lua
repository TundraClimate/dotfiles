local keymap = vim.keymap.set

keymap('i', 'jj', '<esc>')
keymap('i', 'ｊｊ', '<esc>')
keymap('i', 'JJ', '<esc>')

keymap('i', '<c-space>', '<C-n>')

keymap('n', 'H', '10h')
keymap('n', 'J', '10j')
keymap('n', 'K', '10k')
keymap('n', 'L', '10l')
keymap('n', '<right>', ':bNext<enter>')

local telescope = require("telescope.builtin")

keymap('n', '<leader>ff', telescope.find_files, {})
keymap('n', '<leader>fg', telescope.live_grep, {})
keymap('n', '<leader>fb', telescope.buffers, {})
keymap('n', '<leader>glog', telescope.git_commits, {})
keymap('n', '<leader>gstu', telescope.git_status, {})

local mdhelper = require("markdownhelper")

keymap("i", "**", mdhelper.glob)
-- keymap("i", "``", mdhelper.cspan)
-- keymap("i", "```", mdhelper.cblock)
keymap("i", "~~", mdhelper.stth)
-- keymap("i", "[", mdhelper.bracket)
-- keymap("i", "(", mdhelper.paren)
