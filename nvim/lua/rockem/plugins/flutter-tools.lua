return {
	"nvim-flutter/flutter-tools.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
	},
	config = function()
		local flutter_tools = require("flutter-tools")

		flutter_tools.setup({
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
	end,
}
