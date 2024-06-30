return {
  {
    "bluz71/vim-nightfly-colors"
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    "petertriho/nvim-scrollbar",
    event = "User AstroFile",
    config = function()
      require("scrollbar").setup({
        handle = {
          blend = 10,
          color = "#226688",
        },
        marks = {
          Search = {
            text = "-",
            color = "#F0F0F0"
          },
          Error = {
            color = "#FF0000"
          },
          Warn = {
            color = "#FFFF00"
          },
        },
        handlers = {
          cursor = false,
        }
      })
    end
  },
  {
    'MeanderingProgrammer/markdown.nvim',
    event = "User AstroFile",
    name = 'render-markdown',            -- Only needed if you have another plugin named markdown.nvim
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- Mandatory
      'nvim-tree/nvim-web-devicons',     -- Optional but recommended
    },
    config = function()
      require('render-markdown').setup({})
    end,
  }
}
