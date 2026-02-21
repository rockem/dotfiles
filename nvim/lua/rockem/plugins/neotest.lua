return {
	"nvim-neotest/neotest",
	cmd = "Neotest",
	keys = {
		{
			"<leader>tt",
			function()
				require("neotest").run.run()
			end,
			desc = "Run nearest test",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run file tests",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle test summary",
		},
		{
			"<leader>to",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Toggle test output",
		},
		{
			"<leader>ta",
			function()
				require("neotest").run.run(vim.fn.getcwd())
			end,
			desc = "Run all tests",
		},
		{
			"<leader>tO",
			function()
				require("neotest").output.open({ enter = true })
			end,
			desc = "Show test output",
		},
		{
			"<leader>tl",
			function()
				require("neotest").run.run_last()
			end,
			desc = "Run last test",
		},
	},
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"sidlatau/neotest-dart",
		"mrcjkb/rustaceanvim",
		"nvim-neotest/neotest-python",
	},
	config = function()
		-- local device_id = vim.g.flutter_device_id
		require("neotest").setup({
			adapters = {
				require("neotest-dart")({
					command = "flutter",
					use_lsp = true,
				}),
				require("rustaceanvim.neotest"),
				require("neotest-python"),
			},
			log_level = vim.log.levels.WARN,
			timeout = 30000,
			output_panel = {
				open_on_run = true,
			},
			consumers = {
				live_output = function(client)
					client.listeners.run = function(_, _)
						-- Clear and close previous output before opening new one
						require("neotest").output_panel.clear()
						-- require("neotest").output.open({ enter = false, auto_close = false })
					end
				end,
			},
			output = {
				enabled = true,
				open_on_run = "short",
			},
			quickfix = {
				enabled = false,
			},
		})
	end,
}
