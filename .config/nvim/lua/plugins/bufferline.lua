return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "BufEnter",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    options = {
      separator_style = "slant",
      sort_by = "id",
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,

      custom_areas = {
        right = function()
          local result = {}
          local seve = vim.diagnostic.severity
          local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
          local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
          local info = #vim.diagnostic.get(0, { severity = seve.INFO })
          local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

          if error ~= 0 then
            table.insert(result, { text = "  " .. error, link = "DiagnosticError" })
          end

          if warning ~= 0 then
            table.insert(result, { text = "  " .. warning, link = "DiagnosticWarn" })
          end

          if hint ~= 0 then
            table.insert(result, { text = "  " .. hint, link = "DiagnosticHint" })
          end

          if info ~= 0 then
            table.insert(result, { text = "  " .. info, link = "DiagnosticInfo" })
          end
          return result
        end,
      },
    },
  },
}
