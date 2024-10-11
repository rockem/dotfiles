return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    -- configure lualine with modified theme
    lualine.setup({
      options = {
         theme = "ayu_mirage",
      },
      sections = {
        lualine_c = {
          -- { require('auto-session.lib').current_session_name },
          { 'filename', path = 4}},
      lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding" },
          -- { "fileformat" },
          { "filetype" },
        },
      },
    })
  end,
}

