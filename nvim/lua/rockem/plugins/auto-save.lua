return {
	"Pocco81/auto-save.nvim",
	enabled = false,
	event = "BufReadPost",
	opts = {
		debounce_delay = 2000,
		trigger_events = { "InsertLeave", "BufLeave" },
	},
}
