local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")

local function get_decorated_definitions(bufnr)
  local parser = vim.treesitter.get_parser(bufnr, "python")
  local tree = parser:parse()[1]
  local root = tree:root()

  local decorated_definitions = {}
  local query = vim.treesitter.query.parse(
    "python",
    [[
      (decorated_definition) @decorated
      (decorator) @decorator
    ]]
  )

  -- Iterate over captured nodes
  local decorators = {}
  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    if query.captures[id] == "decorator" then
      local decorator_node = node
      local decorator_text = vim.treesitter.get_node_text(decorator_node, bufnr)

      -- Exclude the @property decorator explicitly
      if decorator_text ~= "@property" then
        -- Add all other decorators
        table.insert(decorators, decorator_node)
      end
    end
  end

  -- After filtering out @property, find the decorated definitions that are associated with other decorators
  for _, decorator_node in ipairs(decorators) do
    local start_row, _, end_row, _ = vim.treesitter.get_node_range(decorator_node)
    local decorated_node = decorator_node:parent()
    local start_row_decorated, _, end_row_decorated, _ = vim.treesitter.get_node_range(decorated_node)

    table.insert(decorated_definitions, {
      start_row = start_row_decorated + 1,
      end_row = end_row_decorated + 1,
      text = vim.api.nvim_buf_get_lines(bufnr, start_row_decorated, end_row_decorated + 1, false)[1],
    })
  end

  return decorated_definitions
end

local function decorated_definitions_picker(opts)
  opts = opts or {}
  local bufnr = vim.api.nvim_get_current_buf()
  local decorated_definitions = get_decorated_definitions(bufnr)

  pickers
    .new(opts, {
      prompt_title = "Decorated Definitions",
      finder = finders.new_table({
        results = decorated_definitions,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.text,
            ordinal = entry.text,
            lnum = entry.start_row,
            col = 0,
          }
        end,
      }),
      sorter = conf.generic_sorter(opts),
      previewer = previewers.new_buffer_previewer({
        define_preview = function(self, entry)
          local start_row = entry.value.start_row - 1
          local end_row = entry.value.end_row
          local lines = vim.api.nvim_buf_get_lines(bufnr, start_row, end_row, false)
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
          vim.api.nvim_buf_set_option(self.state.bufnr, "filetype", "python")
          vim.api.nvim_buf_set_option(self.state.bufnr, "bufhidden", "wipe")
        end,
      }),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          -- Ensure cursor is moved to the correct line and column
          vim.api.nvim_win_set_cursor(0, { selection.value.start_row, 0 })
        end)
        return true
      end,
    })
    :find()
end

return {
  decorated_definitions_picker = decorated_definitions_picker,
}
