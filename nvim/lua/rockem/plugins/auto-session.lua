return {
	"rmagatti/auto-session",
	lazy = false,
	priority = 50,
	config = function()
		require("auto-session").setup({
			log_level = "error",
			auto_session_suppress_dirs = { "~/", "~/Downloads", "/", "~/Desktop" },
			auto_session_use_git_branch = true,
			auto_save_enabled = true,
			auto_restore_enabled = true,
			auto_session_enable_last_session = false,
			post_restore_cmds = {
				function()
					-- Force treesitter to reattach to all buffers
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						if vim.api.nvim_buf_is_loaded(buf) then
							vim.api.nvim_buf_call(buf, function()
								vim.cmd("edit")
							end)
						end
					end
				end,
			},
		})
	end,
}
