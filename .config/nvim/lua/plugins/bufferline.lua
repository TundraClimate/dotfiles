return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "BufEnter",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    options = {
      indicator = {
        style = "underline",
      },

      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
    },
  },
}
