-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
-- Delete Default Keymaps
-- local vim = vim or require('vim')

--Import get_keymap function
require("config.keymaps.general")

-- Import Neotree
require("config.keymaps.neotree")

-- Import Python Terminal
require("config.keymaps.python_terminal")

vim.api.nvim_set_keymap(
  "n",
  "<leader>Fd",
  "<cmd>lua require('config.utils.finders').decorated_definitions_picker()<CR>",
  { desc = "[F]ind [D]ecorators", noremap = true, silent = true }
)
