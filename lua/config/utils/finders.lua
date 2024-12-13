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
  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    if query.captures[id] == "decorator" then
      local decorator_node = node
      local decorator_text = vim.treesitter.get_node_text(decorator_node, bufnr)

      -- Exclude the @property decorator explicitly
      if decorator_text == "@property" then
        goto continue
      end
    end

    if query.captures[id] == "decorated" then
      local start_row, _, end_row, _ = vim.treesitter.get_node_range(node)
      table.insert(decorated_definitions, {
        start_row = start_row + 1,
        end_row = end_row + 1,
        text = vim.api.nvim_buf_get_lines(bufnr, start_row, end_row + 1, false)[1],
      })
    end

    ::continue::
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
