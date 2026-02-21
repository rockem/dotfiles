return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
	},
	keys = {
		{ "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle a breakpoint" },
		{ "<leader>dc", function() require("dap").continue() end, desc = "Debug continue" },
	},
}
