-- Neotree
vim.keymap.set("n", "<leader>e", function()
  vim.cmd("Neotree toggle")
end)

vim.keymap.set("n", "<leader>E", function()
  local current_path = vim.fn.expand("%:p:h")
  vim.cmd("Neotree toggle position=left " .. current_path)
end, { desc = "Open Neotree", noremap = true, silent = true })

vim.keymap.set("n", "<leader>fe", function()
  require("config.utils.search_file").open_neotree_project_dir()
end, { desc = "Open Neotree in Project Dir", noremap = true, silent = true })

vim.keymap.set("n", "<leader>fE", function()
  require("config.utils.search_file").open_neotree_in_subfolder()
end, { desc = "Open Neotree in Subfolder", noremap = true, silent = true })
