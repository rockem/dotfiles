return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
        "html",
        "bash",
        "lua",
        "dockerfile",
        "gitignore",
        "python",
        "http",
        "dart",
        "javascript",
        "typescript",
        "astro",
        "rust",
      },
      -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      -- treesitter textobjects configuration
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
            ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
            ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
            ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
            ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },
            ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
            ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
            ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
            ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
            ["ab"] = { query = "@block.outer", desc = "Select outer part of a block" },
            ["ib"] = { query = "@block.inner", desc = "Select inner part of a block" },
            ["a/"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
            ["i/"] = { query = "@comment.inner", desc = "Select inner part of a comment" },
          },
          -- You can choose the select mode (default is charwise 'v')
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "V", -- linewise
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>sn"] = { query = "@parameter.inner", desc = "Swap parameter with next" },
            ["<leader>sm"] = { query = "@function.outer", desc = "Swap function with next" },
          },
          swap_previous = {
            ["<leader>sp"] = { query = "@parameter.inner", desc = "Swap parameter with previous" },
            ["<leader>sM"] = { query = "@function.outer", desc = "Swap function with previous" },
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = { query = "@function.outer", desc = "Next function start" },
            ["]M"] = { query = "@class.outer", desc = "Next class start" },
            ["]a"] = { query = "@parameter.inner", desc = "Next parameter start" },
            ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
            ["]b"] = { query = "@block.outer", desc = "Next block start" },
            ["]/"] = { query = "@comment.outer", desc = "Next comment start" },
          },
          goto_next_end = {
            ["]F"] = { query = "@function.outer", desc = "Next function end" },
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
            ["]A"] = { query = "@parameter.inner", desc = "Next parameter end" },
            ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
            ["]B"] = { query = "@block.outer", desc = "Next block end" },
          },
          goto_previous_start = {
            ["[m"] = { query = "@function.outer", desc = "Previous function start" },
            ["[M"] = { query = "@class.outer", desc = "Previous class start" },
            ["[a"] = { query = "@parameter.inner", desc = "Previous parameter start" },
            ["[i"] = { query = "@conditional.outer", desc = "Previous conditional start" },
            ["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
            ["[b"] = { query = "@block.outer", desc = "Previous block start" },
            ["[/"] = { query = "@comment.outer", desc = "Previous comment start" },
          },
          goto_previous_end = {
            ["[F"] = { query = "@function.outer", desc = "Previous function end" },
            ["[C"] = { query = "@class.outer", desc = "Previous class end" },
            ["[A"] = { query = "@parameter.inner", desc = "Previous parameter end" },
            ["[I"] = { query = "@conditional.outer", desc = "Previous conditional end" },
            ["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
            ["[B"] = { query = "@block.outer", desc = "Previous block end" },
          },
        },
      },
    })
  end,
}
