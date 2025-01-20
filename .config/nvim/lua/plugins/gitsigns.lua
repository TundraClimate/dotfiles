return {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  opts = {},
  keys = {
    { "<leader>gd", '<cmd>lua require("gitsigns").diffthis(_, {split = "botright"})<CR><C-w>w' },
  },
}
