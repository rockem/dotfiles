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
map("i", "<C-Tab>", "<esc>:b#<CR>")

-- Git
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview git changes" })
map("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Git blame" })

-- Fuzzy find
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files in cwd" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Find recent files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Find string in cwd" })
map(
  "n",
  "<leader>fc",
  "<cmd>Telescope find_files search_dirs=~/.config/nvim<CR>",
  { desc = "Find config files" }
)
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "File explorer" })

-- Testing (Neotest)
map("n", "<leader>tt", function()
  require("neotest").run.run()
end, { desc = "Run nearest test" })
map("n", "<leader>tf", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run file tests" })
map("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, { desc = "Toggle test summary" })
map("n", "<leader>to", function()
  require("neotest").output_panel.toggle()
end, { desc = "Toggle test output" })
map("n", "<leader>ta", function()
  require("neotest").run.run(vim.fn.getcwd())
end, { desc = "Run all tests" })
map("n", "<leader>tO", function()
  require("neotest").output.open({ enter = true })
end, { desc = "Show test output" })
map("n", "<leader>tl", function()
  require("neotest").run.run_last()
end, { desc = "Run last test" })
