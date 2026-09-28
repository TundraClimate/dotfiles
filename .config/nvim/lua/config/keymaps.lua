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

m("n", "<up>", function() vim.api.nvim_buf_delete(0, { force = true }) end)
m("n", "<left>", "<cmd>bprevious<cr>")
m("n", "<right>", "<cmd>bnext<cr>")

-- telescope
local telescope = require("telescope.builtin")

m("n", "<leader>ff", telescope.find_files, {})
m("n", "<leader>fg", telescope.live_grep, {})
m("n", "<leader>fc", telescope.current_buffer_fuzzy_find, {})
m("n", "<leader>fr", telescope.lsp_references, {})
m("n", "<leader>gc", telescope.git_commits, {})

local function has_git_changes()
    local gitsigns = require("gitsigns")

    local hunks = gitsigns.get_hunks()
    if hunks and #hunks > 0 then
        return true
    else
        return false
    end
end

m("n", "<leader>gt", function()
    if has_git_changes() then
        telescope.git_status()
    else
        require("notify")("Buffer no changes")
    end
end, {})
