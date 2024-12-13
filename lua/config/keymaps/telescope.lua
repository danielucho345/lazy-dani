local M = {}

local telescope_builtin = require("telescope.builtin")

function M.find_files_current_folder()
  telescope_builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
end

return M
