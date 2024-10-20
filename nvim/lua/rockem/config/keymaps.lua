-- set leader key to space
vim.g.mapleader = " "

local map = vim.keymap.set -- for conciseness

map("n", "<C-Tab>", ":b#<CR>")

-- Git 
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview git changes" })
