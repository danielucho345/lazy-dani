return {
  "numToStr/Comment.nvim",
  config = function()
    local status_ok, todo = pcall(require, "todo-comments")
    if not status_ok then
      print("not todo-comments")
      return
    end

    todo.setup({
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = {
          icon = " ",
          color = "error",
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
        },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TODO = { icon = " ", color = "info", alt = { "TASK" } },
        FIXME = { icon = " ", color = "error", alt = { "BUG", "ISSUE" } },
        HACK = { icon = " ", color = "warning", alt = { "WORKAROUND" } },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "CAUTION" } },
        PERF = { icon = " ", color = "hint", alt = { "OPTIMIZE", "PERFORMANCE" } },
        TEST = { icon = " ", color = "test", alt = { "TESTING" } },
        STUB = { icon = " ", color = "hint", alt = { "STUB" } },
      },
      gui_style = {
        fg = "NONE",
        bg = "BOLD",
      },
      merge_keywords = true,
      highlight = {
        multiline = true,
        multiline_pattern = "^.",
        multiline_context = 10,
        before = "",
        keyword = "wide",
        after = "fg",
        pattern = { [[.*<(KEYWORDS)\s* ]], [[.*<(KEYWORDS):* ]] },
        comments_only = true,
        max_line_len = 400,
        exclude = {},
      },
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" },
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        pattern = [[\b(KEYWORDS) ]],
      },
    })

    local wk = require("which-key")
    wk.register({
      t = {
        name = "Todo",
        j = {
          function()
            require("todo-comments").jump_next()
          end,
          "Next todo comment",
        },
        k = {
          function()
            require("todo-comments").jump_prev()
          end,
          "Previous todo comment",
        },
      },
    }, { prefix = "<leader>" })
  end,
}
