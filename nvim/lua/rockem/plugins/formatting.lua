vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

local conform = require("conform")

conform.setup({
  formatters = {
    black = {
      prepend_args = { "--fast" },
    },
  },
  formatters_by_ft = {
    yaml = { "prettier" },
    lua = { "stylua" },
    markdown = { "prettier" },
    json = { "prettier" },
    python = { "isort", "black" },
    astro = { "prettier" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    svelte = { "prettier" },
    rust = { "rustfmt" },
    zig = { "zigfmt" },
    swift = { "swiftformat" },
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 5000,
  },
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format file or range" })
