vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.pack.add({ "https://github.com/nvim-tree/nvim-tree.lua" })

require("nvim-tree").setup({
	view = {
		float = {
			enable = true,
			open_win_config = function()
				local cols, lines = vim.o.columns, vim.o.lines - vim.o.cmdheight
				local width = math.floor(cols * 0.5)
				local height = math.floor(lines * 0.9)
				return {
					relative = "editor",
					border = "rounded",
					width = width,
					height = height,
					col = math.floor((cols - width) / 2),
					row = math.floor((lines - height) / 2 - 1),
				}
			end,
		},
	},
	renderer = {
		indent_markers = { enable = true },
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	update_focused_file = {
		enable = true,
	},
	filters = {
		custom = { ".DS_Store" },
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "File explorer" })
