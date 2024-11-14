vim.api.nvim_create_autocmd({ "FocusLost" }, {
	callback = function()
		local filename = vim.fn.expand("%")
		local is_file = vim.bo.buftype == ""
		local has_name = #vim.api.nvim_buf_get_name(0) ~= 0
		if
			is_file
			and vim.fn.filereadable(filename) ~= 0
			and not vim.bo.readonly
			and has_name
			and vim.bo.buflisted
		then
			vim.cmd("silent w")
		end
	end,
})
