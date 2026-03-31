-- Build fzf native lib if missing
local fzf_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/telescope-fzf-native.nvim"
if vim.fn.filereadable(fzf_path .. "/build/libfzf.so") == 0 then
  vim.system({ "make" }, { cwd = fzf_path }):wait()
end

vim.pack.add({
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  "https://github.com/debugloop/telescope-undo.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
})

local telescope = require("telescope")
local actions = require("telescope.actions")
local utils = require("telescope.utils")

telescope.setup({
  defaults = {
    path_display = function(_, path)
      local tail = utils.path_tail(path)
      return string.format("%s (%s)", tail, utils.path_smart(path))
    end,
    mappings = {
      i = {
        ["<C-h>"] = actions.which_key,
      },
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!.git/",
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      find_command = {
        "fd",
        "--type",
        "f",
        "--hidden",
        "--follow",
        "--exclude",
        ".git",
      },
    },
    buffers = {
      sort_lastused = true,
      sort_mru = true,
      ignore_current_buffer = true,
    },
  },
  extensions = {
    undo = {
      saved_only = false,
      layout_config = {
        preview_width = 0.7,
      },
    },
  },
})
telescope.load_extension("fzf")
telescope.load_extension("undo")

local map = vim.keymap.set
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files in cwd" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Find recent files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Find string in cwd" })
map("n", "<leader>fc", "<cmd>Telescope find_files search_dirs=~/.config/nvim<CR>", { desc = "Find config files" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>U", "<cmd>Telescope undo<CR>", { desc = "Toggle undo tree ui" })
