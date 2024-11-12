-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set -- for conciseness

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Show Lazy" })

-- Editor
map("n", "<leader>R", ':<C-u>registers<CR>:normal! "p<Left>', { desc = "Select from register" })
map("n", "<leader>U", ":Telescope undo<CR>", { desc = "Toggle undo tree ui" })

-- Buffer
map("n", "<C-Tab>", ":b#<CR>")
map("i", "<C-Tab>", ":b#<CR>")

-- Git
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview git changes" })
map("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Get status" })
map("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Git blame" })

-- Fuzzy find
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files in cwd" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Find recent files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Find string in cwd" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Find string in cwd" })
map(
	"n",
	"<leader>fc",
	"<cmd>Telescope find_files search_dirs=~/.config/nvim<CR>",
	{ desc = "Find config files" }
)
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "File explorer" })
