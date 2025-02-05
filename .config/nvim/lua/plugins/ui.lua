return {
  {
    "rcarriga/nvim-notify",
    lazy = false,
    specs = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    opts = {
      background_colour = "#181825",
    },
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {},
  },
  {
    "stevearc/dressing.nvim",
    event = "BufRead",
    opts = {},
  },
  {
    "onsails/lspkind.nvim",
    event = "InsertEnter",
    opts = {
      mode = "symbol",
      symbol_map = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
      },
      menu = {},
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufRead",
    opts = {
      indent = {
        char = "▏",
        highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
        },
      },
    },
    config = function(_, opts)
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)
      require("ibl").setup(opts)
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    event = "BufRead",
    opts = {
      excluded_filetypes = {
        "dropbar_menu",
        "dropbar_menu_fzf",
        "DressingInput",
        "cmp_docs",
        "cmp_menu",
        "noice",
        "prompt",
        "TelescopePrompt",
        "neo-tree",
      },
      handle = {
        blend = 10,
        color = "#226688",
      },
      marks = {
        Search = {
          text = "-",
          color = "#F0F0F0",
        },
        Error = {
          color = "#FF0000",
        },
        Warn = {
          color = "#FFFF00",
        },
      },
      handlers = {
        cursor = false,
      },
    },
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    event = "BufRead",
    opts = {},
  },
}
