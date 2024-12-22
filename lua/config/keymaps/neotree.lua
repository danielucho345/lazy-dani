local M = {}
local utils = require("config.utils.search_file")

M.neotree_toggle = function()
  vim.cmd("Neotree toggle")
end

M.neotree_current_project_root = function()
  local root = utils.get_project_root()
  vim.cmd("Neotree " .. root)
end

M.neotree_current_file = function()
  local curreneotree_path = vim.fn.expand("%:p:h")
  vim.cmd("Neotree " .. curreneotree_path)
end

return M
