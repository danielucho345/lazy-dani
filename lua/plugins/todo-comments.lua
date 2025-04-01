return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup({
      signs = true,      -- show icons in the signs column
      sign_priority = 8, -- sign priority
      keywords = {
        FIX = {
          icon = "🔧", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        },
        -- TODO:
        -- TODO = { icon = "✅", color = "warning" },

        -- HACK:
        HACK = { icon = "💻", color = "warning" },
        WARN = { icon = "⚠️", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "🚀", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "PERF", "OPTIM", "OPT" } },
        NOTE = { icon = "📝", color = "hint", alt = { "INFO" } },
        TEST = { icon = "🧪", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        REVIEW = { icon = "🔍", color = "test", alt = { "REVIEW", "REV" } },
        LINK = { icon = "🔗", color = "test", alt = { "LINK", "URL" } },
        IDEA = { icon = "💡", color = "hint", alt = { "THOUGHT", "SUGGESTION" } },
        QUESTION = { icon = "❓", color = "info", alt = { "QUERY", "Q" } },
        DEPRECATED = { icon = "⚠️", color = "warning", alt = { "OLD", "REMOVE" } },
        -- FIX = {
        --   icon = " ", -- icon used for the sign, and in search results
        --   color = "error", -- can be a hex color, or a named color (see below)
        --   alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        -- },
        -- -- TODO:
        --TODO = { icon = " ", color = "info" },
        -- HACK = { icon = " ", color = "warning" },
        -- WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        -- PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        -- NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        FAILED_TEST = { icon = "🚨", color = "error", alt = { "TESTING", "PASSED", "FAILED" } },
        STUB = { icon = "📂", color = "test", alt = { "SECTION", "!SECTION" } },
        -- TEST: asdfasdf
        -- STUB: ASDfasdfasdf
        -- SECTION: fasdfasdf
      },

      gui_style = {
        fg = "NONE",               -- The gui style to use for the fg highlight group.
        bg = "BOLD",               -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true,       -- when true, custom keywords will be merged with the defaults
      highlight = {
        multiline = true,          -- enable multine todo comments
        multiline_pattern = "^.",  -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10,    -- extra lines that will be re-evaluated when changing a line
        before = "",               -- "fg" or "bg" or empty
        keyword = "wide",          -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg",              -- "fg" or "bg" or empty
        pattern = {
          [[.*<(KEYWORDS)\s*:]],   -- pattern or table of patterns, used for highlighting (vim regex)
          [[.*"""(KEYWORDS)\s*:]], -- pattern to match Python triple-quoted comments
        },
        comments_only = true,      -- uses treesitter to match keywords in comments only
        max_line_len = 400,        -- ignore lines longer than this
        exclude = {},              -- list of file types to exclude highlighting
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
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      },
    })
  end,
}
