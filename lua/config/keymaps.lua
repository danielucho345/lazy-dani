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

vim.api.nvim_set_keymap(
  "n",
  "<leader>Fd",
  "<cmd>lua require('config.utils.finders').decorated_definitions_picker()<CR>",
  { desc = "[F]ind [D]ecorators", noremap = true, silent = true }
)

local wk = require("which-key")

wk.register({
  ["e"] = {
    function()
      require("config.keymaps.neotree").neotree_toggle()
    end,
    " Toggle Neotree",
    icon = "⏺️",
  },
  ["f"] = {
    name = "[f]ind",
    ["f"] = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "Find Files", icon = "🔍" },
    ["F"] = {
      function()
        require("config.keymaps.telescope").find_files_current_folder()
      end,
      "Files Current Folder",
      icon = "📂",
    },
    ["b"] = { "<cmd>lua require('telescope.builtin').buffers()<CR>", "Find Buffers", icon = "📑" },
  },
}, { prefix = "<leader>" })
