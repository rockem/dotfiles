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
            -- Open the live output pane when a test is running
            require("neotest").output_panel.open({
              enter = false,
              follow = true, -- Keep it updated with real-time output
            })
          end
        end,
      },
    })
  end,
}
