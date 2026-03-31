-- Auto-install without confirmation prompt (confirm = true would block init.lua)
local _pack_add = vim.pack.add
vim.pack.add = function(specs)
  return _pack_add(specs, { confirm = false })
end

-- Build hooks for plugins that require a post-install step.
-- Must be registered before vim.pack.add() calls.
vim.api.nvim_create_autocmd("User", {
  pattern = "PackChanged",
  callback = function(ev)
    if ev.data.kind ~= "install" and ev.data.kind ~= "update" then
      return
    end
    local name = ev.data.spec.name
    local path = ev.data.path

    if name == "telescope-fzf-native.nvim" then
      vim.system({ "make" }, { cwd = path }):wait()
    elseif name == "LuaSnip" then
      vim.system({ "make", "install_jsregexp" }, { cwd = path }):wait()
    elseif name == "markdown-preview.nvim" then
      vim.system({ "sh", "-c", "cd app && yarn install" }, { cwd = path }):wait()
    elseif name == "CopilotChat.nvim" then
      vim.system({ "make", "tiktoken" }, { cwd = path }):wait()
    end
  end,
})

-- Core shared dependencies (no dedicated config file)
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-neotest/nvim-nio",
})

-- Load plugins in dependency order
require("rockem.plugins.colorscheme")
require("rockem.plugins.auto-session")
require("rockem.plugins.which-key")
require("rockem.plugins.nvim-treesitter")
require("rockem.plugins.telescope")
require("rockem.plugins.gitsigns")
require("rockem.plugins.indent-blankline")
require("rockem.plugins.nvim-colorizer")
require("rockem.plugins.nvim-illuminate")
require("rockem.plugins.mason")
require("rockem.plugins.lspconfig")
require("rockem.plugins.copilot")
require("rockem.plugins.nvim-cmp")
require("rockem.plugins.copilot-chat")
require("rockem.plugins.formatting")
require("rockem.plugins.linting")
require("rockem.plugins.lualine")
require("rockem.plugins.nvim-tree")
require("rockem.plugins.harpoon")
require("rockem.plugins.trouble")
require("rockem.plugins.dressing")
require("rockem.plugins.nvim-autopairs")
require("rockem.plugins.nvim-surround")
require("rockem.plugins.comment")
require("rockem.plugins.rustaceanvim")
require("rockem.plugins.flutter-tools")
require("rockem.plugins.debugging")
-- require("rockem.plugins.neotest")  -- disabled
require("rockem.plugins.vim-test")
-- require("rockem.plugins.auto-save")  -- disabled
require("rockem.plugins.bullets")
require("rockem.plugins.markdown-preview")
require("rockem.plugins.render-markdown")
require("rockem.plugins.pre-commit")
require("rockem.plugins.vim-be-good")
