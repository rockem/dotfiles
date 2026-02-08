local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true         -- shows absolute line number on cursor line (when relative number is on)
vim.opt.showbreak = '↪ '

-- tabs & indentation
opt.tabstop = 2       -- 2 spaces for tabs (prettier default)
opt.softtabstop = 2
opt.shiftwidth = 2    -- 2 spaces for indent width
opt.expandtab = true  -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true

-- line wrapping
opt.wrap = false -- disable line wrapping
opt.textwidth = 120

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.signcolumn = "yes" -- Show sign column so that text doesn't shift
opt.scrolloff = 8
opt.isfname:append("@-@")
opt.colorcolumn = "120"
opt.shortmess:append("I")

opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- Files
opt.swapfile = false -- turn off swapfile
opt.backup = false
opt.autoread = true  -- Turn auto read for changed files
opt.history = 50
opt.autowriteall = true

opt.shada = "!,'20,<50,s10,h"

opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- completion
opt.wildmode = "longest:full,full"
opt.wildmenu = true

-- Spell
opt.spell = true
