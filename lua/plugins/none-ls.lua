return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    -- Enable debug logging
    null_ls.setup({
      debug = true,
      sources = {
        null_ls.builtins.diagnostics.mypy, -- Add mypy for Python type checking
      },
    })
  end,
}
