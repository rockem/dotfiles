-- set leader key to space
vim.g.mapleader = " "

local map = vim.keymap.set -- for conciseness

map("n", "<leader>sv", "<C-w>v") -- split window vertically
map("n", "<leader>sh", "<C-w>s") -- split window horizontally
map("n", "<leader>se", "<C-w>=") -- make split window equal width
map("n", "<leader>sx", ":close<CR>") -- close current split window

map("n", "<C-TAB>", ":b#<CR>")

