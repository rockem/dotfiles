return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	ft = { "rust" },
	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()

		-- 2. Enable the file watching capability
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
					},
				},
			},
		}
		vim.api.nvim_create_autocmd("TermOpen", {
			callback = function()
				vim.cmd("normal! G")
			end,
		})
	end,
}
