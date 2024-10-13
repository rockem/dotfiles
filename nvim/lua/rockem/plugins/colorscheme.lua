return {
	{
    "Shatur/neovim-ayu",
		priority = 1000, -- Make sure this loads before all others
		config = function()
      require("ayu").setup({
        mirage = true
      })
			-- load colorscheme here
			vim.cmd([[colorscheme ayu-mirage]])
		end,
	},
}

