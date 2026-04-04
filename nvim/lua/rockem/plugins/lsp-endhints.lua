vim.pack.add("https://github.com/chrisgrieser/nvim-lsp-endhints")

require("lsp-endhints").setup({
	icons = {
		type = "=> ",
		parameter = "<- ",
	},
	label = {
		truncateAtChars = 70,
	},
})
