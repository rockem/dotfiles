return {
	{
    "Shatur/neovim-ayu",
    name="ayu",
		priority = 1000, -- Make sure this loads before all others
		config = function()
      require("ayu").setup({
        mirage = true
      })
		end,
	},
  { 
    "catppuccin/nvim", 
    name = "catppuccin", 
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe"
      })
    end,
  }
}

