return {
  "folke/trouble.nvim",
  config = function()
    local actions = require("telescope.actions")
    local open_with_trouble = require("trouble.sources.telescope").open

    -- Use this to add more results without clearing the trouble list
    local add_to_trouble = require("trouble.sources.telescope").add

    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        mappings = {
          i = { ["<c-f>"] = open_with_trouble },
          n = { ["<c-f>"] = open_with_trouble },
        },
      },
    })
  end,
}
