return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
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
        typescript = { "prettier" },
        svelte = { "prettier" },
        rust = { "rustfmt" },
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
  end,
}
