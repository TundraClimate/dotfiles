vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.lazy")
require("config.keymaps")
require("config.options")
require("config.autocmds")

vim.cmd.colorscheme("nightfly")
