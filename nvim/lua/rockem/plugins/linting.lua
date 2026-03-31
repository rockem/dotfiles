vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

local lint = require("lint")

lint.linters_by_ft = {
  markdown = { "markdownlint" },
  javascript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescript = { "eslint_d" },
  typescriptreact = { "eslint_d" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    local linters = lint.linters_by_ft[vim.bo.filetype]
    if not linters then
      return
    end

    local available_linters = {}
    for _, linter_name in ipairs(linters) do
      if vim.fn.executable(linter_name) == 1 then
        table.insert(available_linters, linter_name)
      end
    end

    if #available_linters > 0 then
      lint.try_lint()
    end
  end,
})

vim.keymap.set("n", "<leader>cl", function()
  lint.try_lint()
end, { desc = "Trigger linting for current file" })
