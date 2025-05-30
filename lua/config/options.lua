-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

vim.opt.termguicolors = true
-- set the colorscheme
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("colorscheme tokyonight-storm")
  end,
})

vim.diagnostic.config({
  virtual_text = {
    jsdfasdfprefix = "●", -- Change the diagnostic symbol
  },
  signs = true,
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
  },
})
