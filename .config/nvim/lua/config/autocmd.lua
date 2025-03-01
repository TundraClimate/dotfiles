vim.api.nvim_create_augroup("my_autocmd", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
  group = "my_autocmd",
  callback = function()
    local last_pos = vim.fn.line("'\"")
    local last_line = vim.fn.line("$")
    if last_pos > 0 and last_pos <= last_line then
      vim.cmd('normal! g`"')
    end
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = "my_autocmd",
  callback = function()
    if vim.fn.exists("g:lazy_auto_update") == 0 then
      vim.g.lazy_auto_update = true
      vim.fn.jobstart({ "nvim", "--headless", "'Lazy! sync'", "+qa" }, { detach = true })
    end
  end,
})
