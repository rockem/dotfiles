return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files in cwd" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Find recent files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Find string in cwd" },
		{ "<leader>fc", "<cmd>Telescope find_files search_dirs=~/.config/nvim<CR>", desc = "Find config files" },
		{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
		{ "<leader>U", "<cmd>Telescope undo<CR>", desc = "Toggle undo tree ui" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"debugloop/telescope-undo.nvim",
	},
	opts = {},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local utils = require("telescope.utils")

		telescope.setup({
			defaults = {
				path_display = function(_, path)
					local tail = utils.path_tail(path)
					return string.format("%s (%s)", tail, utils.path_smart(path))
				end,
				-- layout_strategy = "horizontal",
				-- layout_config = {
				-- 	width = 0.95,
				-- 	preview_width = 0.45,
				-- },
				mappings = {
					i = {
						["<C-h>"] = actions.which_key,
					},
				},
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--glob=!.git/",
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					find_command = {
						"fd",
						"--type",
						"f",
						"--hidden",
						"--follow",
						"--exclude",
						".git",
					},
				},
			},
			extensions = {
				undo = {
					saved_only = false,
					layout_config = {
						preview_width = 0.7,
					},
				},
			},
		})
		telescope.load_extension("fzf")
		telescope.load_extension("undo")
	end,
}
