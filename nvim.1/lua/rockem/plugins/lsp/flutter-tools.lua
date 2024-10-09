return {
	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = function()
      local lsp_bindings = require("rockem.common.lsp-bindings")
			require("flutter-tools").setup({
        lsp = {
          on_attach = lsp_bindings.keymap,
          renameFilesWithClasses = "always"
        }
      })
		end,
	},
}
