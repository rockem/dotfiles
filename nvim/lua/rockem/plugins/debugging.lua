vim.pack.add({
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/mfussenegger/nvim-dap",
})

local dap = require("dap")
local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

local map = vim.keymap.set
map("n", "<leader>du", dapui.toggle, { desc = "Toggle debug UI" })
map("n", "<leader>dt", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle a breakpoint" })
map("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Debug continue" })
