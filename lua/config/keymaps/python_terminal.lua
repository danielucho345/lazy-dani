local utils = require("config.utils.search_file")

vim.keymap.set(
  "n",
  "<leader>cp",
  utils.copy_project_relative_path_to_clipboard,
  { desc = "Copy project-relative file path" }
)
vim.keymap.set("n", "<leader>cP", utils.copy_full_path_to_clipboard, { desc = "Copy project-relative file path" })

vim.keymap.set("n", "<leader>cM", utils.copy_python_module_path_to_clipboard, { desc = "Copy project-relative module" })
