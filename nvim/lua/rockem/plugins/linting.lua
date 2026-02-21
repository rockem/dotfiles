return {
	"mfussenegger/nvim-lint",
	ft = { "markdown", "javascript", "javascriptreact", "typescript", "typescriptreact" },
	event = "BufWritePost",
	config = function()
		local lint = require("lint")

		-- Configure linters by filetype
		lint.linters_by_ft = {
			markdown = { "markdownlint" },
			javascript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
		}

		-- Create autocommand for linting
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				-- Get the configured linters for current filetype
				local linters = lint.linters_by_ft[vim.bo.filetype]
				if not linters then
					return
				end

				-- Filter out linters that aren't installed
				local available_linters = {}
				for _, linter_name in ipairs(linters) do
					if vim.fn.executable(linter_name) == 1 then
						table.insert(available_linters, linter_name)
					end
				end

				-- Only try to lint if we have available linters
				if #available_linters > 0 then
					lint.try_lint()
				end
			end,
		})

		-- Optional: Add a keymap to manually trigger linting
		vim.keymap.set("n", "<leader>cl", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
