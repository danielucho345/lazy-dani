return {
  "navarasu/onedark.nvim",
  config = function()
    -- local colorscheme = "tokyonight"
    local colorscheme = "onedark"
    -- local colorscheme = "solarized-osaka-moon"

    local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
    if not status_ok then
      return
    end

    local c = require("onedark.colors")

    require("onedark").setup({
      -- Main options --
      style = "darker", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      transparent = "cool", -- Show/hide background
      term_colors = true, -- Change terminal color as per the selected theme style
      ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
      cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

      -- toggle theme style ---
      toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
      toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

      -- Change code style ---
      -- Options are italic, bold, underline, none
      -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
      code_style = {
        comments = "italic",
        keywords = "none",
        functions = "none",
        strings = "italic",
        variables = "bold",
      },

      -- Lualine options --
      lualine = {
        transparent = false, -- lualine center bar transparency
      },

      -- Custom Highlights --
      colors = {
        bright_orange = "#ff8800", -- define a new color
        green = "#98c379", -- redefine an existing color
        red = "#993939", -- redefine an existing color
      }, -- Override default colors
      highlights = {
        ["@spell"] = { fg = c.green },
        ["@comment"] = { fg = c.black },
        ["@variable"] = { fg = c.red },
        ["@variable@variable"] = { fg = c.yellow },
        ["@variable.builtin"] = { fg = c.yellow },
        ["@variable.member"] = { fg = c.red },
      },
      -- Plugins Config --
      diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
      },
    })
    require("onedark").load()
  end,
}
