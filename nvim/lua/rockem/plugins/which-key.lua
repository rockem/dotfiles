vim.pack.add({ "https://github.com/folke/which-key.nvim" })
require("which-key").setup({
  preset = "modern",
  win = {
    height = { max = 10 },
  },
  layout = {
    width = { min = 20, max = 30 },
  },
  delay = 500,
  spec = {
    { "<leader>g", group = "Git" },
    { "<leader>f", group = "Fuzzy find" },
    { "<leader>s", group = "Swap (Treesitter)" },
    { "<leader>t", group = "Test" },
    { "<leader>c", group = "Code" },
    { "<leader>h", group = "Harpoon" },
  },
  icons = {
    mappings = false,
  },
})
