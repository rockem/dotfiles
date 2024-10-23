vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave", "FocusLost", "WinClosed" }, {
  callback = function ()
    if vim.bo.buftype == "" and #vim.api.nvim_buf_get_name(0) ~= 0 and vim.bo.buflisted then
      vim.cmd "silent w"
    end
  end
})

