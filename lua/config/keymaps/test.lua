local M = {}

-- Function to search with Treesitter query using Telescope
M.search_with_treesitter_query = function()
  local lang = vim.bo.filetype -- Detect language from current buffer
  local query = [[
    (assignment) @variable
  ]]

  local success, parsed_query = pcall(vim.treesitter.query.parse, lang, query)
  if not success then
    vim.notify("Failed to parse Treesitter query for language: " .. lang, vim.log.levels.ERROR)
    return
  end

  local results = {}
  local parser = vim.treesitter.get_parser(0)
  local tree = parser:parse()[1]
  local root = tree:root()

  for id, node, _ in parsed_query:iter_captures(root, 0) do
    local capture_name = parsed_query.captures[id]
    if capture_name == "variable" then
      local start_row, start_col, _, _ = node:range()
      local line_text = vim.api.nvim_buf_get_lines(0, start_row, start_row + 1, false)[1]
      table.insert(results, {
        text = line_text,
        lnum = start_row + 1,
        col = start_col + 1,
      })
    end
  end

  if #results == 0 then
    vim.notify("No variables found in the current buffer.", vim.log.levels.INFO)
    return
  end

  -- Display results in Telescope
  require("telescope.pickers")
    .new({}, {
      prompt_title = "Treesitter Variables",
      finder = require("telescope.finders").new_table({
        results = results,
        entry_maker = function(entry)
          return {
            value = entry,
            display = string.format("%s | Line %d, Col %d", entry.text, entry.lnum, entry.col),
            ordinal = entry.text,
            lnum = entry.lnum,
            col = entry.col,
          }
        end,
      }),
      sorter = require("telescope.config").values.generic_sorter({}),
      previewer = require("telescope.previewers").new_buffer_previewer({
        define_preview = function(self, entry)
          local bufnr = self.state.bufnr
          local line = entry.value.lnum - 1
          local lines = vim.api.nvim_buf_get_lines(0, line, line + 1, false)
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
          vim.api.nvim_buf_add_highlight(bufnr, -1, "TelescopePreviewLine", 0, 0, -1)
          vim.api.nvim_buf_set_option(bufnr, "filetype", vim.bo.filetype)
        end,
      }),
      attach_mappings = function(prompt_bufnr, map)
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        map("i", "<CR>", function()
          local selection = action_state.get_selected_entry()
          if selection then
            vim.api.nvim_win_set_cursor(0, { selection.lnum, selection.col - 1 })
            actions.close(prompt_bufnr)
          end
        end)

        return true
      end,
    })
    :find()
end

-- Keymap setup for the function
M.setup = function()
  vim.keymap.set(
    "n",
    "<leader>ts",
    M.search_with_treesitter_query,
    { noremap = true, silent = true, desc = "Search variables with Treesitter" }
  )
end

return M
