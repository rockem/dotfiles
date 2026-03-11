return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	ft = { "rust" },
	config = function()
		vim.g.rustaceanvim = {
			tools = {
				test_executor = "neotest",
			},
			server = {
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
	end,
}
