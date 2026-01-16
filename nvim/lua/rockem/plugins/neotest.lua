return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "sidlatau/neotest-dart",
    "mrcjkb/rustaceanvim",
    "nvim-neotest/neotest-python"
  },
  config = function()
    -- local device_id = vim.g.flutter_device_id
    require("neotest").setup({
      adapters = {
        require("neotest-dart")({
          command = "flutter",
          use_lsp = true,
        }),
        require("rustaceanvim.neotest"),
        require("neotest-python")
      },
      log_level = vim.log.levels.DEBUG,
      timeout = 30000,
      output_panel = {
        open_on_run = true,
      },
      consumers = {
        live_output = function(client)
          client.listeners.run = function(_, _)
            -- Clear and close previous output before opening new one
            require("neotest").output_panel.clear()
            -- require("neotest").output.open({ enter = false, auto_close = false })
          end
        end,
      },
      output = {
        enabled = true,
        open_on_run = "short",
      },
      quickfix = {
        enabled = false,
      },
    })
  end,
}
