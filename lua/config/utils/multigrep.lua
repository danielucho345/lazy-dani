local pickers = require("telescope.pickers")
local finders_gen = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values
local M = {}

local live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()
  -- opts.cwd = opts.cwd or vim.fn.getcwd()
  local finders = finders_gen.new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local pieces = vim.split(prompt, " ")
      local args = { "rg" }

      if pieces[1] then
        table.insert(args, "-e")
        table.insert(args, pieces[1])
      end

      if pieces[2] then
        table.insert(args, "-g")
        table.insert(args, pieces[2])
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
    end,
    entry_maker = make_entry.gen_from_vimgrep({
      cwd = opts.cwd,
      shorten_path = true,
    }),
  })

  pickers
    .new(opts, {
      prompt_title = "Live Multigrep",
      finders = finders,
      debounce = 100,
      previewer = conf.grep_previewer(opts),
      sorter = require("telescope.sorters").empty(),
    })
    :find()
  M.setup = function() end
end

live_multigrep()

return M
