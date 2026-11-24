vim.pack.add({ "https://github.com/sindrets/diffview.nvim" })

require("diffview").setup({
  enhanced_diff_hl = true,
})

local map = vim.keymap.set
map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Diff view (working tree)" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "File history" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<CR>", { desc = "Branch history" })
map("n", "<leader>gq", "<cmd>DiffviewClose<CR>", { desc = "Close diff view" })
