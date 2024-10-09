return {
	{
		-- "bluz71/vim-nightfly-guicolors",
    -- "catppuccin/nvim",
    -- "rebelot/kanagawa.nvim",
    "Shatur/neovim-ayu",
		priority = 1000, -- Make sure this loads before all others
		config = function()
      require("ayu").setup({
        mirage = true
      })
			-- load colorscheme here
			vim.cmd([[colorscheme ayu]])
		end,
	},
	{
		"savq/melange-nvim",
		version = false,
		lazy = false,
		priority = 1000,
	},
	{
		"ishan9299/modus-theme-vim",
		version = false,
		lazy = false,
		priority = 1000,
	},
	{
		"lifepillar/vim-solarized8",
		version = false,
		lazy = false,
		priority = 1000,
	},
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({
				style = "cool",
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
  {
    "rose-pine/neovim",
		version = false,
		lazy = false,
		priority = 1000,
  },
  {
    "EdenEast/nightfox.nvim",
		version = false,
		lazy = false,
		priority = 1000,
  }
}
