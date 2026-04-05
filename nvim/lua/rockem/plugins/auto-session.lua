vim.pack.add({ "https://github.com/rmagatti/auto-session" })
require("auto-session").setup({
  log_level = "error",
  suppressed_dirs = { "~/", "~/Downloads", "/", "~/Desktop" },
  bypass_save_filetypes = { "terminal", "term" },
  close_unsupported_windows = true,
  git_use_branch_name = true,
  pre_save_cmds = {
    function()
      -- Command to forcefully delete (bd!) all buffers whose names start with 'term://*'
      vim.cmd("bufdo if (bufname() =~ '^term://*') | bd! | endif")
    end,
    function()
      -- Delete buffers whose paths are outside the current working directory
      local cwd = vim.fn.getcwd()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
          local name = vim.api.nvim_buf_get_name(buf)
          if name ~= "" and not vim.startswith(name, cwd) then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
      end
    end,
  },
  post_restore_cmds = {
    function()
      -- Force treesitter to reattach to all buffers
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
          vim.api.nvim_buf_call(buf, function()
            vim.cmd("edit")
          end)
        end
      end
    end,
  },
})
