return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
    },

    opts = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local border_opts = {
        border = "single",
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      }
      return {
        matching = {
          disallow_fuzzy_matching = true,
        },
        sorting = {
          comparators = {
            function(entry1, entry2)
              local prefix = "^" .. vim.api.nvim_get_current_line():match("%S+")
              local match1 = entry1.completion_item.label:match(prefix)
              local match2 = entry2.completion_item.label:match(prefix)

              if match1 and not match2 then
                return true
              elseif match2 and not match1 then
                return false
              end

              if entry1.source.name == "nvim_lsp" and entry2.source.name ~= "nvim_lsp" then
                return true
              elseif entry2.source.name == "nvim_lsp" and entry1.source.name ~= "nvim_lsp" then
                return false
              end

              return nil
            end,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        preselect = cmp.PreselectMode.None,
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = {
              menu = 50,
              abbr = 50,
            },

            ellipsis_char = "...",
            show_labelDetails = true,
          }),
        },
        window = {
          completion = cmp.config.window.bordered(border_opts),
          documentation = cmp.config.window.bordered(border_opts),
        },
        mapping = cmp.mapping.preset.insert({
          ["<tab>"] = cmp.mapping.select_next_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "buffer",   priority = 250 },
          { name = "path",     priority = 100 },
        }),
      }
    end,
  },
}
