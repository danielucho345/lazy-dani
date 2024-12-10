return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting
    -- Enable debug logging
    null_ls.setup({
      debug = true,
      sources = {
        null_ls.builtins.diagnostics.mypy, -- Add mypy for Python type checking
        diagnostics.djlint.with({
          filetypes = { "htmldjango" },
          args = {
            "--lint", -- Lint mode
            "--quiet",
            "$FILENAME",
          },
        }),
        -- Add djlint for formatting
        formatting.djlint.with({
          filetypes = { "htmldjango" },
          args = {
            "--reformat", -- Format mode
            "--quiet",
            "$FILENAME",
          },
        }),
        -- Add other tools (e.g., mypy, ruff, prettier) as needed
      },
    })
  end,
}
