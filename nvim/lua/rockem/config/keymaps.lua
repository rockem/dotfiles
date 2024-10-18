-- set leader key to space
vim.g.mapleader = " "

local map = vim.keymap.set -- for conciseness

map("n", "<C-Tab>", ":b#<CR>")

