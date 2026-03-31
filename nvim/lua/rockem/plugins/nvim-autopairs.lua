vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })

local autopairs = require("nvim-autopairs")

autopairs.setup({
  check_ts = true,
  ts_config = {
    lua = { "string" },
    javascript = { "template_string" },
    java = false,
  },
})

-- import nvim-autopairs completion functionality (only if cmp is available)
local cmp_status_ok, cmp = pcall(require, "cmp")
if cmp_status_ok then
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end
