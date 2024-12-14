local M = {}

local telescope_builtin = require("telescope.builtin")

function M.find_files_current_folder()
  telescope_builtin.find_files({
    cwd = vim.fn.expand("%:p:h"),
    prompt_title = "Find Files in Current Folder",
  })
end

function M.find_files_gitignore()
  telescope_builtin.find_files({
    find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
    prompt_title = "Find Files (.gitignore)",
  })
end

function M.find_files_no_gitignore()
  telescope_builtin.find_files({
    find_command = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!.git/*" },
    prompt_title = "Find Files (No .gitignore)",
  })
end

function M.find_files_in_static()
  telescope_builtin.find_files({
    cwd = vim.fn.expand("static/"), -- Establece el directorio de trabajo a 'static/'
    prompt_title = "Find Files in Static Folder",
  })
end

return M
