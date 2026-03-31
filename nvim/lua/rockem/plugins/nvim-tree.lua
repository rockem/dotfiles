vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.pack.add({ "https://github.com/nvim-tree/nvim-tree.lua" })

require("nvim-tree").setup({
  view = {
    width = 30,
  },
  renderer = {
    indent_markers = { enable = true },
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  update_focused_file = {
    enable = true,
  },
  filters = {
    custom = { ".DS_Store" },
  },
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "File explorer" })
