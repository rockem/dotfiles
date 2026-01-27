return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = "auto",
			},
			sections = {
				lualine_c = {
					-- { require('auto-session.lib').current_session_name },
					{ "filename", path = 4 },
				},
				lualine_x = {
					{
						function()
							local neotest = require("neotest")
							local status = neotest.state.status_counts(
								neotest.state.adapter_ids()[1] or "neotest"
							)
							if not status then
								return ""
							end

							local passed = status.passed or 0
							local failed = status.failed or 0
							local skipped = status.skipped or 0
							local running = status.running or 0

							if running > 0 then
								return string.format("🧪 Running: %d", running)
							elseif failed > 0 then
								return string.format("✗ %d ✓ %d", failed, passed)
							elseif passed > 0 then
								return string.format("✓ %d", passed)
							end
							return ""
						end,
						color = function()
							local neotest = require("neotest")
							local status = neotest.state.status_counts(
								neotest.state.adapter_ids()[1] or "neotest"
							)
							if not status then
								return nil
							end

							if (status.running or 0) > 0 then
								return { fg = "#89b4fa" } -- blue for running
							elseif (status.failed or 0) > 0 then
								return { fg = "#f38ba8" } -- red for failures
							elseif (status.passed or 0) > 0 then
								return { fg = "#a6e3a1" } -- green for passing
							end
						end,
					},
					-- {
					-- 	lazy_status.updates,
					-- 	cond = lazy_status.has_updates,
					-- 	color = { fg = "#ff9e64" },
					-- },
					{ "encoding" },
					-- { "fileformat" },
					{ "filetype" },
				},
				-- lualine_y = {
				-- 	{
				-- 		function()
				-- 			local target_time = os.time({ year = 2023, month = 10, day = 7 })
				-- 			local current_time = os.time()
				-- 			local difference_in_seconds = current_time - target_time
				-- 			local days_passed = math.floor(difference_in_seconds / (60 * 60 * 24))
				-- 				+ 1
				-- 			return string.format("\u{1F397}%s", days_passed)
				-- 		end,
				-- 		color = { fg = "#f9e2af" },
				-- 	},
				-- },
			},
		})
	end,
}
