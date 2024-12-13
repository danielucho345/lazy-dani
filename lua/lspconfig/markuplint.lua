local lspconfig = require("lspconfig")

lspconfig.markuplint = {
  default_config = {
    cmd = { "markuplint", "--stdin" },
    filetypes = { "html", "htmldjango" },
    root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
    settings = {},
  },
  docs = {
    description = [[
https://github.com/markuplint/markuplint

A linter for HTML, supporting custom elements and attributes.
]],
    default_config = {
      root_dir = [[root_pattern(".git", vim.fn.getcwd())]],
    },
  },
}
