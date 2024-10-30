return {
	-- {
	-- 	"Shatur/neovim-ayu",
	-- 	name = "ayu",
	-- 	priority = 1000, -- Make sure this loads before all others
	-- 	config = function()
	-- 		require("ayu").setup({
	-- 			mirage = true,
	-- 		})
	-- 	end,
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		opts = {
			integrations = {
				cmp = true,
				indent_blankline = { enabled = true },
				gitsigns = true,
				mason = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				telescope = true,
				treesitter = true,
				treesitter_context = true,
				which_key = true,
			},
		},
		config = function()
			vim.api.nvim_set_hl(0, "MyScopeHL", { fg = "#4b4c68" })
			require("catppuccin").setup({
				flavour = "frappe",
			})
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
}
