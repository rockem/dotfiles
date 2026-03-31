vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

local lualine = require("lualine")

-- Helper to safely get neotest status without forcing it to load
local function get_neotest_status()
  local ok, neotest = pcall(require, "neotest")
  if not ok then
    return nil
  end
  local adapters = neotest.state.adapter_ids()
  if not adapters or #adapters == 0 then
    return nil
  end
  return neotest.state.status_counts(adapters[1])
end

lualine.setup({
  options = {
    theme = "auto",
  },
  sections = {
    lualine_c = {
      { "filename", path = 4 },
    },
    lualine_x = {
      {
        function()
          local status = get_neotest_status()
          if not status then
            return ""
          end

          local passed = status.passed or 0
          local failed = status.failed or 0
          local running = status.running or 0

          if running > 0 then
            return string.format("Running: %d", running)
          elseif failed > 0 then
            return string.format("x %d / %d", failed, passed)
          elseif passed > 0 then
            return string.format("v %d", passed)
          end
          return ""
        end,
        color = function()
          local status = get_neotest_status()
          if not status then
            return nil
          end

          if (status.running or 0) > 0 then
            return { fg = "#89b4fa" }
          elseif (status.failed or 0) > 0 then
            return { fg = "#f38ba8" }
          elseif (status.passed or 0) > 0 then
            return { fg = "#a6e3a1" }
          end
        end,
      },
      { "encoding" },
      { "filetype" },
    },
  },
})
