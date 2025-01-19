return {
  {
    "rcarriga/nvim-notify",
    event = "BufEnter",
    specs = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    opts = {}
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {}
  }
}
