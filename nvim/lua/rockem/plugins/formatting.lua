return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function ()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        yaml = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        json = { "prettier" },
        python = { "isort", "black" }
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range" })
    -- asljnasljdkn
    -- as;d;ljasdlkj
    -- alsdjkalsdjk
    --
  end
}
