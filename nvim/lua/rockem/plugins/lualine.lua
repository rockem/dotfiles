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
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					-- { "fileformat" },
					{ "filetype" },
				},
				lualine_y = {
					{
						function()
							local target_time = os.time({ year = 2023, month = 10, day = 7 })
							local current_time = os.time()
							local difference_in_seconds = current_time - target_time
							local days_passed = math.floor(difference_in_seconds / (60 * 60 * 24))
								+ 1
							return string.format("\u{1F397}%s", days_passed)
						end,
						color = { fg = "#f9e2af" },
					},
				},
			},
		})
	end,
}
