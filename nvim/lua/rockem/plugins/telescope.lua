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

      local map = vim.keymap.set

      map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files in cwd" })
      map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Find recent files" })
      map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Find string in cwd" })
      map("n", "<leader>fc", "<cmd>Telescope find_files search_dirs=~/.config/nvim<CR>", { desc = "Find config files" })

    end,
}
