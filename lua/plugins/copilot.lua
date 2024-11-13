return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  opts = {
    suggestion = {
      enabled = not vim.g.ai_cmp,
      auto_trigger = true,
      keymap = {
        accept = "<C-l>", -- Use a different key if <Tab> conflicts with nvim-cmp
        next = "<M-]>",
        prev = "<M-[>",
      },
    },
    panel = { enabled = false },
    filetypes = {
      markdown = true,
      help = true,
      lua = true, -- Add other filetypes as needed
    },
  },
  config = function(_, opts)
    require("copilot").setup(opts)
  end,
}
