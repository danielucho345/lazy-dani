local M = {}

function M.get_project_root()
  local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
  for _, client in ipairs(clients) do
    if client.config.root_dir then
      return client.config.root_dir
    end
  end

  local git_root = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")
  if vim.v.shell_error == 0 then
    return git_root
  end

  return vim.fn.getcwd()
end

function M.copy_project_relative_path_to_clipboard()
  local file_path = vim.fn.expand("%")
  if file_path == "" or file_path == nil then
    vim.notify("No file open or unnamed buffer", vim.log.levels.WARN)
    return
  end

  local root = M.get_project_root()
  local relative_path = file_path:gsub("^" .. root:gsub("%%", "%%%%") .. "/", "")

  vim.fn.setreg("+", relative_path)
  vim.notify("Copied project-relative path to clipboard: " .. relative_path, vim.log.levels.INFO)
end

function M.copy_full_path_to_clipboard()
  local file_path = vim.fn.expand("%:p") -- Expand to absolute path
  if file_path == "" or file_path == nil then
    vim.notify("No file open or unnamed buffer", vim.log.levels.WARN)
    return
  end

  vim.fn.setreg("+", file_path) -- Copy the full path to the clipboard
  vim.notify("Copied full file path to clipboard: " .. file_path, vim.log.levels.INFO)
end

function M.copy_python_module_path_to_clipboard()
  local file_path = vim.fn.expand("%:p:r") -- Expand to absolute path without extension
  if file_path == "" or file_path == nil then
    vim.notify("No file open or unnamed buffer", vim.log.levels.WARN)
    return
  end

  local root = M.get_project_root()
  local relative_path = file_path:gsub("^" .. root:gsub("%%", "%%%%") .. "/", "")
  local module_path = relative_path:gsub("/", ".")

  local command = "python3 -m " .. module_path
  vim.fn.setreg("+", command) -- Copy the command to the clipboard
  vim.notify("Copied command to clipboard: " .. command, vim.log.levels.INFO)
end

return M
