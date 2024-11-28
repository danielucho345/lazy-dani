-- local function get_project_root()
--
--   -- Try to use LSP to determine the root
--   local clients = vim.lsp.get_active_clients()
--   for _, client in ipairs(clients) do
--     if client.config.root_dir then
--       return client.config.root_dir
--     end
--   end
--
--   -- Fallback to Git if LSP is not available
--   local git_root = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")
--   if vim.v.shell_error == 0 then
--     return git_root
--   end
--
--   -- Default to Neovim's current working directory
--   return vim.fn.getcwd()
-- end
--
-- local function copy_project_relative_path_to_clipboard()
--   local file_path = vim.fn.expand("%")
--   if file_path == "" then
--     vim.notify("No file open to copy path from", vim.log.levels.WARN)
--     return
--   end
--
--   -- Get the project root dynamically
--   local root = get_project_root()
--
--   -- Make the file path relative to the project root
--   local relative_path = file_path:gsub("^" .. vim.fn.escape(root, "\\") .. "/", "")
--
--   vim.fn.setreg("+", relative_path) -- Copy to system clipboard
--   vim.notify("Copied project-relative path to clipboard: " .. relative_path, vim.log.levels.INFO)
-- end
--
-- -- Keymap
-- vim.keymap.set("n", "<leader>cp", copy_project_relative_path_to_clipboard, { desc = "Copy project-relative file path" })
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

return M
