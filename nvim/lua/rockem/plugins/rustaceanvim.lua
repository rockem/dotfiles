vim.pack.add({ { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range(">=5.0,<6.0") } })

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.workspace = {
  didChangeWatchedFiles = {
    dynamicRegistration = true,
  },
}
vim.g.rustaceanvim = {
  server = {
    capabilities = capabilities,
    default_settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
        check = {
          command = "clippy",
        },
      },
    },
  },
}
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd("normal! G")
  end,
})
