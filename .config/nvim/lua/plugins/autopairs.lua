return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {},
  config = function(opts)
    require("nvim-autopairs").setup(opts)

    require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
  end,
}
