return {
  "nvim-tree/nvim-tree.lua",
	cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "File explorer" },
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons"
	},
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  config = function()
    local nvim_tree = require("nvim-tree")

    nvim_tree.setup({
      view = {
        width = 30,
      },
      renderer = {
        indent_markers = { enable = true }
      },
      actions ={
        open_file = {
          quit_on_open = true,
        }
      },
      update_focused_file = {
        enable = true
      },
      filters = {
        custom = { ".DS_Store" },
      },
    })
  end,
}
