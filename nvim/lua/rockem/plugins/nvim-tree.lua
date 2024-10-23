return {
  "nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons"
	},
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

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
