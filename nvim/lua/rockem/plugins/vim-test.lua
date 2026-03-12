return {
	"vim-test/vim-test",
	keys = {
		{ "<leader>tt", "<cmd>wa | TestNearest<CR>", desc = "Run nearest test" },
		{ "<leader>tf", "<cmd>wa | TestFile<CR>", desc = "Run file tests" },
		{ "<leader>ta", "<cmd>wa | TestSuite<CR>", desc = "Run all tests" },
		{ "<leader>tl", "<cmd>wa | TestLast<CR>", desc = "Run last test" },
		{ "<leader>tv", "<cmd>wa | TestVisit<CR>", desc = "Visit test file" },
	},
	config = function()
		vim.g["test#strategy"] = "neovim_sticky"
		vim.g["test#neovim#start_normal"] = 1
		vim.g["test#preserve_screen"] = 0
		vim.g["test#neovim_sticky#reopen_window"] = 1
		vim.g["test#neovim_sticky#use_existing"] = 1
	end,
}
