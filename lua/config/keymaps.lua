-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Delete Default Keymaps
require("config.keymaps.delete_keymaps")
--Import get_keymap function
require("config.keymaps.general")

-- Import Neotree
require("config.keymaps.neotree")

-- Import Python Terminal
require("config.keymaps.python_terminal")
-- Delete the keymap for opening the terminal

-- vim.api.nvim_set_keymap(
--   "n",
--   "<leader>Fd",
--   "<cmd>lua require('config.utils.finders').decorated_definitions_picker()<CR>",
--   { desc = "[F]ind [D]ecorators", noremap = true, silent = true }
-- )

local wk = require("which-key")

wk.register({
  ["e"] = {
    "<cmd>lua require('config.keymaps.neotree').neotree_toggle()<CR>",
    "Toggle neotree",
    icon = "⏺️",
  },
  ["f"] = {
    name = "[f]ind",
    ["f"] = { "<cmd>lua require('config.keymaps.telescope').find_files_gitignore()<CR>", "Find Files", icon = "🔍" },
    ["F"] = {
      function()
        require("config.keymaps.telescope").find_files_current_folder()
      end,
      "Files Current Folder",
      icon = "📂",
    },
    ["b"] = { "<cmd>lua require('telescope.builtin').buffers()<CR>", "Find Buffers", icon = "📑" },
    ["s"] = {
      "<cmd>lua require('config.keymaps.telescope').find_files_in_static() <CR>",
      "Find in Static",
      icon = "📁",
    },
  },
  ["F"] = {
    name = "Find (in code)",
    ["d"] = {
      "<cmd>lua require('config.utils.finders').decorated_definitions_picker()<CR>",
      "[F]ind [d]ecorators",
      icon = "✨",
    },
    ["p"] = {
      "<cmd>lua require('config.utils.finders').decorated_properties_picker()<CR>",
      "[F]ind [p]roperties",
      icon = "🔍",
    },
    ["v"] = {
      "<cmd>lua require('config.utils.finders').variables_picker()<CR>",
      "[F]ind [v]ariables",
      icon = "🔍",
    },
  },
}, { prefix = "<leader>" })
