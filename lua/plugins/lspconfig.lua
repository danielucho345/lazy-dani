return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      ----------------------------------------Lua----------------------------------------
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      },
      ----------------------------------------Python----------------------------------------
      pyright = {
        settings = {
          pyright = {
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              autoSearchPaths = true,
              typeCheckingMode = "basic",
              useLibraryCodeForTypes = true,
              include = { "src", "package", "**/package" },
            },
          },
        },
      },
      ruff = {
        init_options = {
          single_file_support = false,
          root_dir = vim.fn.getcwd(),
          settings = {
            args = {
              "--select=ALL",
              "--ignore=RET504,TD002,TD001,TD003,PD015,S101,DTZ005",
              "--line-length=100",
            },
          },
        },
      },
      ----------------------------------------HTML----------------------------------------
      html = {
        single_file_support = false,
        filetypes = { "html", "htmldjango" },
        settings = {
          html = {
            format = {
              wrapLineLength = 120,
              unformatted = "pre,code,textarea",
              contentUnformatted = "pre,code,textarea",
              indentInnerHtml = true,
              preserveNewLines = true,
              maxPreserveNewLines = 2,
              indentHandlebars = false,
              endWithNewline = true,
              extraLiners = "head, body, /html",
              wrapAttributes = "force-aligned",
            },
          },
        },
      },
      ----------------------------------------DjLint----------------------------------------
      djlint = {
        settings = {
          args = {
            "--ignore=E001,E002",
            "--extension=html,htm,htmldjango",
          },
        },
      },
    },
  },
}
