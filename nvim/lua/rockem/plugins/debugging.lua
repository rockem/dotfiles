return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
	},
	event = "VeryLazy",
	config = function()
		local dap = require("dap")

		local keymap = vim.keymap

		keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle a breakpoint" })
		keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug continue" })
	end,
}
