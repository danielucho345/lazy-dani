return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  cmd = "CopilotChat",
  opts = function()
    local user = vim.env.USER or "User"
    user = user:sub(1, 1):upper() .. user:sub(2)
    return {
      auto_insert_mode = true,
      question_header = "  " .. user .. " ",
      answer_header = "  Copilot ",
      window = {
        width = 0.4,
      },
    }
  end,
  keys = {
    { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
    { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    {
      "<leader>aa",
      function()
        local chat = require("CopilotChat")
        if chat then
          chat.toggle()
        else
          vim.notify("CopilotChat is not loaded", vim.log.levels.ERROR)
        end
      end,
      desc = "Toggle (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>ax",
      function()
        local chat = require("CopilotChat")
        if chat then
          chat.reset()
        else
          vim.notify("CopilotChat is not loaded", vim.log.levels.ERROR)
        end
      end,
      desc = "Clear (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>aq",
      function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          local chat = require("CopilotChat")
          if chat then
            chat.ask(input)
          else
            vim.notify("CopilotChat is not loaded", vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Quick Chat (CopilotChat)",
      mode = { "n", "v" },
    },
  },
  config = function(_, opts)
    local ok, chat = pcall(require, "CopilotChat")
    if not ok then
      vim.notify("CopilotChat failed to load", vim.log.levels.ERROR)
      return
    end

    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "copilot-chat",
      callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
      end,
    })

    chat.setup(opts)
  end,
}
