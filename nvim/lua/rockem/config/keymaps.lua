-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set -- for conciseness

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Show Lazy" })

-- Editor
map("n", "<leader>R", ':<C-u>registers<CR>:normal! "p<Left>', { desc = "Select from register" })
map("n", "gF", function()
	local word = vim.fn.expand("<cWORD>")
	local file, line, col = word:match("([^:]+):(%d+):(%d+)")

	if not file then
		file, line = word:match("([^:]+):(%d+)")
	end

	if not file then
		file = vim.fn.expand("<cfile>")
	end

	vim.cmd("wincmd w | edit " .. vim.fn.fnameescape(file))

	if line then
		vim.api.nvim_win_set_cursor(0, { tonumber(line), tonumber(col or 1) - 1 })
	end
end, { desc = "Open file under cursor in other window" })

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
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<CR>", { desc = "Location list (Trouble)" })
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix list (Trouble)" })
