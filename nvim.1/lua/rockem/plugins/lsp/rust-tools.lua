return {
  "simrat39/rust-tools.nvim",

  config = function()
    local rt = require("rust-tools")
    local lsp_bindings = require("rockem.common.lsp-bindings")

    rt.setup({
      runnables = {
        use_telescope = true,
      },
      inlay_hints = {
        auto = true,
        show_parameter_hints = false,
        parameter_hints_prefix = "",
        other_hints_prefix = "",
      },

      server = {
        on_attach = lsp_bindings.keymap,
        settings ={
          ["rust-analyzer"] = {
            -- enable clippy on save
            checkOnSave = {
              command = "clippy",
            },
            diagnostics = {
              experimental = {
                enable = true
              }
            },
          },
        },
      },
    })
  end
}
