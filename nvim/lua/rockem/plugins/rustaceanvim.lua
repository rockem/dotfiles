return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  ft = { "rust" },
  config = function()
    vim.g.rustaceanvim = {
      server = {
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
  end,
}
