return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "BufRead",
    opts = {},
  },
}
