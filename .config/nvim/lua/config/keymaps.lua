local m = vim.keymap.set

-- alt escape
m("i", "jj", "<esc>")
m("i", "JJ", "<esc>")
m("i", "ｊｊ", "<esc>")

-- moves
m("n", "j", "gj")
m("n", "k", "gk")
m("v", "j", "gj")
m("v", "k", "gk")

m("n", "H", "10h")
m("n", "J", "10gj")
m("n", "K", "10gk")
m("n", "L", "10l")
m("v", "H", "10h")
m("v", "J", "10gj")
m("v", "K", "10gk")
m("v", "L", "10l")

m("n", "<c-j>", "<c-f>")
m("n", "<c-k>", "<c-b>")
m("v", "<c-j>", "<c-f>")
m("v", "<c-k>", "<c-b>")

-- buffer
m("n", "<c-s>", "<cmd>w<cr>")
m("n", "<tab>", "<c-w><c-w>")

m("n", "<up>", "<cmd>q!<cr>")
m("n", "<left>", "<cmd>bprevious<cr>")
m("n", "<right>", "<cmd>bnext<cr>")
