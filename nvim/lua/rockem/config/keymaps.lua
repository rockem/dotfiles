-- set leader key to space
vim.g.mapleader = " "

local map = vim.keymap.set -- for conciseness

map("n", "<C-Tab>", ":b#<CR>")

map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files in cwd" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Find recent files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Find string in cwd" })
map("n", "<leader>fc", "<cmd>Telescope find_files search_dirs=~/.config/nvim<CR>", { desc = "Find config files" })

-- Git 
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview git changes" })
