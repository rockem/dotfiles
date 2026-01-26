return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		win = {
			height = { max = 10 },
		},
		layout = {
			width = { min = 20, max = 30 },
		},
		delay = 500,
		spec = {
			{ "<leader>g", group = "Git" },
			{ "<leader>f", group = "Fuzzy find" },
			{ "<leader>s", group = "Swap (Treesitter)" },
			{ "<leader>t", group = "Test" },
		},
		icons = {
			mappings = false,
		},
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
}
