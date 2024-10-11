return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				rust = { "rustfmt" },
				lua = { "stylua" },
				python = { "isort", "black" },
				yaml = { "yamlfix" },
			},
		})

    -- gemes hello
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format gemes file or range (in visual mode)" })
	end,
}
