vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
})

-- New API: setup() only accepts install_dir
require("nvim-treesitter").setup()

-- Enable treesitter highlighting and indentation for all filetypes
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
    if vim.bo.indentexpr == "" then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- Install parsers that aren't already installed
local ensure_installed = {
  "json", "yaml", "markdown", "markdown_inline", "html", "bash", "lua",
  "dockerfile", "gitignore", "python", "dart", "javascript", "typescript",
  "tsx", "astro", "rust", "zig",
}
for _, lang in ipairs(ensure_installed) do
  local ok = pcall(vim.treesitter.language.inspect, lang)
  if not ok then
    pcall(require("nvim-treesitter.install").install, lang)
  end
end

-- Textobjects setup
require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
    selection_modes = {
      ["@parameter.outer"] = "v",
      ["@function.outer"] = "V",
      ["@class.outer"] = "V",
    },
  },
  move = {
    set_jumps = true,
  },
})

local map = vim.keymap.set

-- Select text objects
map({ "x", "o" }, "af", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects") end, { desc = "Select outer part of a function" })
map({ "x", "o" }, "if", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects") end, { desc = "Select inner part of a function" })
map({ "x", "o" }, "ac", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects") end, { desc = "Select outer part of a class" })
map({ "x", "o" }, "ic", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects") end, { desc = "Select inner part of a class" })
map({ "x", "o" }, "aa", function() require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects") end, { desc = "Select outer part of a parameter" })
map({ "x", "o" }, "ia", function() require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects") end, { desc = "Select inner part of a parameter" })
map({ "x", "o" }, "ai", function() require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer", "textobjects") end, { desc = "Select outer part of a conditional" })
map({ "x", "o" }, "ii", function() require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner", "textobjects") end, { desc = "Select inner part of a conditional" })
map({ "x", "o" }, "al", function() require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer", "textobjects") end, { desc = "Select outer part of a loop" })
map({ "x", "o" }, "il", function() require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner", "textobjects") end, { desc = "Select inner part of a loop" })
map({ "x", "o" }, "ab", function() require("nvim-treesitter-textobjects.select").select_textobject("@block.outer", "textobjects") end, { desc = "Select outer part of a block" })
map({ "x", "o" }, "ib", function() require("nvim-treesitter-textobjects.select").select_textobject("@block.inner", "textobjects") end, { desc = "Select inner part of a block" })

-- Swap text objects
map("n", "<leader>sn", function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end, { desc = "Swap parameter with next" })
map("n", "<leader>sp", function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner") end, { desc = "Swap parameter with previous" })
map("n", "<leader>sm", function() require("nvim-treesitter-textobjects.swap").swap_next("@function.outer") end, { desc = "Swap function with next" })
map("n", "<leader>sM", function() require("nvim-treesitter-textobjects.swap").swap_previous("@function.outer") end, { desc = "Swap function with previous" })

-- Move to next/previous text objects
map({ "n", "x", "o" }, "]m", function() require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects") end, { desc = "Next function start" })
map({ "n", "x", "o" }, "]M", function() require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects") end, { desc = "Next function end" })
map({ "n", "x", "o" }, "[m", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects") end, { desc = "Previous function start" })
map({ "n", "x", "o" }, "[M", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects") end, { desc = "Previous function end" })
map({ "n", "x", "o" }, "]a", function() require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner", "textobjects") end, { desc = "Next parameter start" })
map({ "n", "x", "o" }, "[a", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects") end, { desc = "Previous parameter start" })
map({ "n", "x", "o" }, "]i", function() require("nvim-treesitter-textobjects.move").goto_next_start("@conditional.outer", "textobjects") end, { desc = "Next conditional start" })
map({ "n", "x", "o" }, "[i", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@conditional.outer", "textobjects") end, { desc = "Previous conditional start" })
map({ "n", "x", "o" }, "]l", function() require("nvim-treesitter-textobjects.move").goto_next_start("@loop.outer", "textobjects") end, { desc = "Next loop start" })
map({ "n", "x", "o" }, "[l", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@loop.outer", "textobjects") end, { desc = "Previous loop start" })
