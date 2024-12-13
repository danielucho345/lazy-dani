return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- Add htmldjango support
      htmldjango = {
        "djlint", -- Use djlint for Django formatting
      },
      -- html = {
      --   "prettier", -- Use prettier for regular HTML files
      -- },
    },
  },
  -- Optionally, you can set up a keymap for triggering formatting
  config = function(_, opts)
    require("conform").setup(opts)
    vim.api.nvim_set_keymap("n", "<leader>cf", "<cmd>Format<CR>", { noremap = true, silent = true })
  end,
}

