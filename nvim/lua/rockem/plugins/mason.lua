return {
	"williamboman/mason.nvim",
	enabled = true,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local tool_installer = require("mason-tool-installer")

		mason.setup({})

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"pyright",
				"ruff",
				"astro",
				"ts_ls",
			},

			automatic_installation = true,
		})

		tool_installer.setup({
			ensure_installed = {
				"black",
				"debugpy",
				"flake8",
				"dart-debug-adapter",
			},
		})
	end,
}
