-- Neotree
local utils = require("config.utils.search_file")
vim.keymap.set("n", "<leader>e", function()
  vim.cmd("Neotree toggle ")
end, { desc = "Toggle Neotree", noremap = true, silent = true })

vim.keymap.set("n", "<leader>fe", function()
  local root = utils.get_project_root()
  vim.cmd("Neotree " .. root)
end, { desc = "Find file in Neotree", noremap = true, silent = true })

vim.keymap.set("n", "<leader>fE", function()
  local current_path = vim.fn.expand("%:p:h")
  vim.cmd("Neotree toggle position=left " .. current_path)
end, { desc = "Open Neotree", noremap = true, silent = true })
