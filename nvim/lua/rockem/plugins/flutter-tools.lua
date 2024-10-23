return {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
      local flutter_tools = require("flutter-tools")

      flutter_tools.setup({
      lsp = {
        on_attach = require("rockem.plugins.common.lsp-attach").on_attach
      }
    })
    end

}
