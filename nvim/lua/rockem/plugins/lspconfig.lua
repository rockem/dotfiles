return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lsconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = require("rockem.plugins.common.lsp-attach").on_attach,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lsconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,

			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
			["pyright"] = function()
				lspconfig["pyright"].setup({
					capabilities = capabilities,
					filetypes = { "python" },
					settings = {
						pyright = {
							disableOrganizeImports = true,
						},
						python = {
							analysis = {
								ignore = { "*" },
							},
						},
					},
					before_init = function(_, config)
						local default_venv_path = "venv/bin/python"
						config.settings.python.pythonPath = default_venv_path
					end,
				})
			end,
			["ruff"] = function()
				lspconfig["ruff"].setup({
					capabilities = capabilities,
					filetypes = { "python" },
					init_options = {
						settings = {
							ruff = {
								interpreter = { "venv/bin/python" },
							},
						},
					},
				})
			end,
			lspconfig["astro"].setup({
				capabilities = capabilities,
				filetypes = { "astro" },
			}),
			lspconfig["ts_ls"].setup({
				capabilities = capabilities,
				filetypes = { "typescript" },
				settings = {
					completion = {
						completionFunctionCalls = true,
					},
				},
			}),
		})
	end,
}
