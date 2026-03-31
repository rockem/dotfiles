vim.pack.add({ "https://github.com/nvim-flutter/flutter-tools.nvim" })

require("flutter-tools").setup({
  lsp = {
    on_attach = require("rockem.plugins.common.lsp-attach").on_attach,
  },
  widget_guides = { enabled = true },
  debugger = {
    enabled = true,
    run_via_dap = true,
    register_configurations = function(_)
      local dap = require("dap")
      dap.adapters.dart = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
        args = { "flutter" },
      }
      dap.configurations.dart = {}
      require("dap.ext.vscode").load_launchjs()
    end,
  },
})
