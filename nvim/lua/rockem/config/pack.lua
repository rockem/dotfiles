-- Auto-install without confirmation prompt (confirm = true would block init.lua)
local _pack_add = vim.pack.add
---@diagnostic disable-next-line: duplicate-set-field
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
require("rockem.plugins.diffview")
require("rockem.plugins.codediff")
require("rockem.plugins.indent-blankline")
require("rockem.plugins.nvim-colorizer")
require("rockem.plugins.nvim-illuminate")
require("rockem.plugins.mason")
require("rockem.plugins.lspconfig")
require("rockem.plugins.lsp-endhints")
require("rockem.plugins.copilot")
require("rockem.plugins.nvim-cmp")
require("rockem.plugins.copilot-chat")
require("rockem.plugins.formatting")
require("rockem.plugins.linting")
require("rockem.plugins.lualine")
require("rockem.plugins.nvim-tree")
require("rockem.plugins.harpoon")
require("rockem.plugins.trouble")
require("rockem.plugins.nvim-autopairs")
require("rockem.plugins.nvim-surround")
require("rockem.plugins.rustaceanvim")
require("rockem.plugins.flutter-tools")
require("rockem.plugins.debugging")
require("rockem.plugins.vim-test")
require("rockem.plugins.bullets")
require("rockem.plugins.markdown-preview")
require("rockem.plugins.render-markdown")
require("rockem.plugins.diagram")
require("rockem.plugins.pre-commit")
require("rockem.plugins.vim-be-good")

-- Plugin management helpers
vim.api.nvim_create_user_command("PackUpdate", function(opts)
	vim.pack.update(#opts.fargs > 0 and opts.fargs or nil)
end, {
	nargs = "*",
	complete = function()
		return vim.tbl_map(function(p)
			return p.spec.name
		end, vim.pack.get())
	end,
	desc = "Update vim.pack plugins (all, or the named ones)",
})

vim.api.nvim_create_user_command("PackStatus", function()
	vim.pack.update(nil, { offline = true })
end, { desc = "Browse installed plugins without fetching" })

vim.keymap.set("n", "<leader>pu", "<cmd>PackUpdate<CR>", { desc = "Update plugins" })
vim.keymap.set("n", "<leader>ps", "<cmd>PackStatus<CR>", { desc = "Plugin status" })
