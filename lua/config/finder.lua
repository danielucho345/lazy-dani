function get_local_properties()
  local properties = {}

  -- Get all lines in the current buffer
  local lines = vim.fn.getline(1, "$")

  -- Simple regex to capture local variables and functions
  for _, line in ipairs(lines) do
    -- Match local variable assignments (e.g., local var = value)
    for var in string.gmatch(line, "local%s+([%w_]+)%s*=") do
      table.insert(properties, { key = var, type = "variable" })
    end

    -- Match function definitions (e.g., function my_func() ... end)
    for func in string.gmatch(line, "function%s+([%w_]+)%s*%(") do
      table.insert(properties, { key = func, type = "function" })
    end
  end

  return properties
end

-- Function to display all properties
function display_properties()
  local properties = get_local_properties()

  print("Displaying all properties in the code:")
  for _, prop in ipairs(properties) do
    print(string.format("Property: %s, Type: %s", prop.key, prop.type))
  end
end

-- Call the display function to show the properties
-- display_properties()

-- Add the display properties command to a keybinding
vim.api.nvim_set_keymap(
  "n",
  "<leader>Ft",
  ":lua display_properties()<CR>",
  { noremap = true, silent = true, desc = "Find Property" }
)

-- Custom Telescope function to filter only for properties (fields, variables)
function telescope_lsp_find_variables()
  require("telescope.builtin").lsp_document_symbols({
    symbols = {
      "variable",
      "field",
      "property",
      -- "const", -- Filter for properties or variables
    },
  })
end

-- Bind custom Telescope function to a key
vim.api.nvim_set_keymap(
  "n",
  "<leader>fv",
  ":lua telescope_lsp_find_variables()<CR>",
  { noremap = true, silent = true, desc = "[F]ind [v]ariables" }
)
