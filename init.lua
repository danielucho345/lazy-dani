-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
local utils = require("config.utils.search_file")

vim.keymap.set(
  "n",
  "<leader>cm",
  utils.copy_python_module_path_to_clipboard,
  { desc = "Copy project-relative file path" }
)
