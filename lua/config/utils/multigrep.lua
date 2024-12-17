local pickers = require("telescope.pickers")
local finders_gen = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

local live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.loop.cwd()

  -- Command generator to build arguments
  local function command_generator(prompt)
    if not prompt or prompt == "" then
      vim.notify("Please enter a search query.", vim.log.levels.WARN)
      return nil
    end

    local pieces = vim.split(prompt, " ")
    local args = { "rg" }

    -- File name search
    if pieces[1] and pieces[1] ~= "" then
      table.insert(args, "-e")
      table.insert(args, pieces[1])
    end

    -- File type search
    if pieces[2] and pieces[2] ~= "" then
      table.insert(args, "-g")
      table.insert(args, "*." .. pieces[2])
    end

    -- Ensure there are valid arguments
    if #args <= 1 then
      vim.notify("Invalid search query.", vim.log.levels.WARN)
      return nil
    end

    return vim.tbl_flatten({
      args,
      {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
    })
  end

  -- Create a finder
  local finders = finders_gen.new_async_job({
    command_generator = command_generator,
    entry_maker = make_entry.gen_from_vimgrep({
      cwd = opts.cwd,
      shorten_path = true,
    }),
  })

  -- Ensure finder is valid
  if not finders then
    vim.notify("Finder creation failed. Please check your input.", vim.log.levels.ERROR)
    return
  end

  -- Create and run the picker
  pickers
    .new(opts, {
      prompt_title = "Live Multigrep",
      finder = finders,
      debounce = 100,
      previewer = conf.grep_previewer(opts),
      sorter = require("telescope.sorters").empty(),
      attach_mappings = function(_, map)
        map("i", "<CR>", function(prompt_bufnr)
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            vim.cmd("edit " .. selection.filename)
          end
        end)
        return true
      end,
    })
    :find()
end

M.setup = function()
  vim.keymap.set("n", "<leader>lg", live_multigrep, { desc = "Live Multigrep (Name + Type)" })
end

vim.keymap.set("n", "<leader>lg", live_multigrep, { desc = "Live Multigrep (Name + Type)" })
return M
