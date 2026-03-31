vim.pack.add({
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup({})

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "basedpyright",
    "ruff",
    "astro",
    "ts_ls",
    "zls",
  },
  automatic_installation = true,
})

require("mason-tool-installer").setup({
  ensure_installed = {
    "debugpy",
    "flake8",
    "dart-debug-adapter",
    "markdownlint",
    "eslint_d",
    "swiftformat",
  },
})
