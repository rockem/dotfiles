vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" })
require("copilot").setup({
  -- Inline ghost-text suggestions (replaces the old copilot-cmp completion source)
  suggestion = {
    enabled = true,
    auto_trigger = true,
    hide_during_completion = true,
    keymap = {
      accept = "<Tab>",
      accept_word = "<M-w>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  panel = { enabled = false },
})
