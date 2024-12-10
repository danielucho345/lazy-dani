return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      -- Lua
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
      -- HTML emmet
      emmet_language_server = {
        filetypes = {
          "html",
          "htmldjango",
        },
        init_options = {
          configurationSection = { "html", "css", "javascript", "htmldjango" },
          embeddedLanguages = {
            css = true,
            javascript = true,
            html = true,
            htmldjango = true,
          },
          provideFormatter = true,
        },
      },
      -- HTML
      html = {
        filetypes = { "html" },
        init_options = {
          provideFormatter = true,
        },
      },
      -- pyright will be automatically installed with mason and loaded with lspconfig
      pyright = {
        handlers = {
          ["textDocument/publishDiagnostics"] = function() end,
        },
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
      -- Ruff
      ruff = {
        init_options = {
          single_file_support = false,
          root_dir = vim.fn.getcwd(),
          settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {
              "--select=ALL",
              "--ignore=RET504,TD002,TD001,TD003,PD015,S101,DTZ005",
              "--line-length=100",
            },
          },
        },
      },
    },
  },
}
