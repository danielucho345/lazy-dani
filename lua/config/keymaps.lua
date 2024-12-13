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

local wk = require("which-key")

-- Keymaps find

wk.register({
  ["<leader>"] = {
    f = {
      name = "Find",
      --Find Files current directory
      f = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "Find Files" },
      -- Find Files current folder
      F = {
        "<cmd>lua require('telescope.builtin').find_files({cwd = vim.fn.expand('%:p:h')})<CR>",
        "Find Files in Folder",
      },
      --Find Buffers
      b = { "<cmd>lua require('telescope.builtin').buffers()<CR>", "Find Buffers" },
      --Find Config Files
      c = { "<cmd>lua require('telescope.builtin').find_files({cwd = '~/.config/nvim'})<CR>", "Find Config Files" },
      --Find Git Files
      g = { "<cmd>lua require('telescope.builtin').git_files()<CR>", "Find Git Files" },
      --Find Recent Files
      r = { "<cmd>lua require('telescope.builtin').oldfiles()<CR>", "Find Recent Files" },
      --Find
    },
  },
})
