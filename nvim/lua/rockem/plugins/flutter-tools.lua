return {
	"nvim-flutter/flutter-tools.nvim",
	lazy = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local flutter_tools = require("flutter-tools")
		local cmp_lsp = require("cmp_nvim_lsp")

		local capabilities = cmp_lsp.default_capabilities()

		flutter_tools.setup({
			lsp = {
				on_attach = require("rockem.plugins.common.lsp-attach").on_attach,
				capabilities = capabilities,
			},
			widget_guides = { enabled = true },
		})
	end,
}
