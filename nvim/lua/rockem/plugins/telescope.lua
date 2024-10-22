return {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-tree/nvim-web-devicons",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defauls = {
          path_display = { "smart" }
        }
      })
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")

    end,
}
