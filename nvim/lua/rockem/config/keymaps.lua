-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set -- for conciseness

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Show Lazy" })

-- Editor
map("n", "<leader>R", ':<C-u>registers<CR>:normal! "p<Left>', { desc = "Select from register" })

-- Buffer
map("n", "<C-Tab>", ":b#<CR>")
map("i", "<C-Tab>", "<esc>:b#<CR>")

-- Git
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview git changes" })
map("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Git blame" })

-- Pre commit
vim.keymap.set("n", "<leader>cp", "<cmd>Precommit<CR>", { desc = "Run all pre-commit hooks" })

-- Trouble (diagnostics)
map(
	"n",
	"<leader>xx",
	"<cmd>Trouble diagnostics toggle<CR>",
	{ desc = "Toggle diagnostics (Trouble)" }
)
map(
	"n",
	"<leader>xX",
	"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
	{ desc = "Buffer diagnostics (Trouble)" }
)
map(
	"n",
	"<leader>xs",
	"<cmd>Trouble symbols toggle focus=false<CR>",
	{ desc = "Symbols (Trouble)" }
)
map(
	"n",
	"<leader>xl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
	{ desc = "LSP references (Trouble)" }
)
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<CR>", { desc = "Location list (Trouble)" })
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix list (Trouble)" })
