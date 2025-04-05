local keymap = vim.keymap.set

keymap("i", "jj", "<esc>")
keymap("i", "ｊｊ", "<esc>")
keymap("i", "JJ", "<esc>")

keymap("n", "j", "gj")
keymap("n", "H", "10h")
keymap("n", "J", "10gj")
keymap("n", "K", "10gk")
keymap("n", "L", "10l")
keymap("n", "<c-j>", "<C-f>")
keymap("n", "<c-k>", "<C-b>")
keymap("v", "j", "gj")
keymap("v", "H", "10h")
keymap("v", "J", "10gj")
keymap("v", "K", "10gk")
keymap("v", "L", "10l")
keymap("n", "<right>", "<cmd>bprevious<cr>")
keymap("n", "<up>", function()
  vim.api.nvim_buf_delete(0, { force = true })
end)
keymap("n", "<C-e><C-e>", "f{a<enter><esc>ko")
keymap("n", "??", "f;i?<esc>")
keymap("n", "<C-s>", "<cmd>w<cr>")

local telescope = require("telescope.builtin")

local function has_git_changes()
  local gitsigns = require("gitsigns")

  local hunks = gitsigns.get_hunks()
  if hunks and #hunks > 0 then
    return true
  else
    return false
  end
end

keymap("n", "<leader>ff", telescope.find_files, {})
keymap("n", "<leader>fg", telescope.live_grep, {})
keymap("n", "<leader>fb", telescope.buffers, {})
keymap("n", "<leader>fc", telescope.current_buffer_fuzzy_find, {})
keymap("n", "<leader>fr", telescope.lsp_references, {})
keymap("n", "<leader>gc", telescope.git_commits, {})
keymap("n", "<leader>t", telescope.diagnostics, {})
keymap("n", "<leader>gt", function()
  if has_git_changes() then
    telescope.git_status()
  else
    require("notify")("Buffer no changes")
  end
end, {})
keymap("n", "<leader>gd", function()
  if has_git_changes() then
    local current_win = vim.api.nvim_get_current_win()
    local wins_before = vim.api.nvim_list_wins()

    require("gitsigns").diffthis()

    vim.defer_fn(function()
      local wins_after = vim.api.nvim_list_wins()

      for _, win in ipairs(wins_after) do
        if not vim.tbl_contains(wins_before, win) and win ~= current_win then
          vim.api.nvim_set_current_win(win)
          break
        end
      end
    end, 100)
  else
    require("notify")("Buffer no changes")
  end
end)
