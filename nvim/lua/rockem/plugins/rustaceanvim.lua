vim.pack.add({
	{ src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range(">=5.0,<6.0") },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.workspace = {
	didChangeWatchedFiles = {
		dynamicRegistration = true,
	},
}
vim.g.rustaceanvim = {
	server = {
		capabilities = capabilities,
		default_settings = {
			["rust-analyzer"] = {
				cargo = {
					allFeatures = true,
				},
				check = {
					command = "clippy",
				},
				inlayHints = {
					bindingModeHints = { enable = false },
					chainingHints = { enable = true },
					closingBraceHints = { enable = true, minLines = 25 },
					closureReturnTypeHints = { enable = "never" },
					lifetimeElisionHints = { enable = "never" },
					parameterHints = { enable = true },
					typeHints = { enable = true },
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
