vim.pack.add({ "https://github.com/esmuellert/codediff.nvim" })

require("codediff").setup({
  highlights = {
    -- Only highlight the changed characters: line-level backgrounds match Normal so whole lines
    -- stay unhighlighted. Char colors are explicit so they aren't derived from the line color.
    line_insert = "Normal",
    line_delete = "Normal",
    char_insert = "#2f4a3d",
    char_delete = "#4a2f3a",
  },
  diff = {
    layout = "inline", -- "side-by-side" | "inline"; toggle per session with `t`
  },
  explorer = {
    view_mode = "tree",
    focus_on_select = true, -- jump to the modified pane after selecting a file
  },
})

local map = vim.keymap.set
map("n", "<leader>gc", "<cmd>CodeDiff<CR>", { desc = "CodeDiff: working tree" })
map("n", "<leader>gC", "<cmd>CodeDiff --staged<CR>", { desc = "CodeDiff: staged changes" })
map("n", "<leader>gm", "<cmd>CodeDiff main...<CR>", { desc = "CodeDiff: branch vs main" })
map("n", "<leader>gf", "<cmd>CodeDiff history %<CR>", { desc = "CodeDiff: file history" })
map("n", "<leader>gF", "<cmd>CodeDiff history<CR>", { desc = "CodeDiff: repo history" })
