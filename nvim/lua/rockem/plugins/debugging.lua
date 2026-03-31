vim.pack.add({
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/mfussenegger/nvim-dap",
})

local map = vim.keymap.set
map("n", "<leader>dt", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle a breakpoint" })
map("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Debug continue" })
