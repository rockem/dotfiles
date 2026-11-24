vim.pack.add({ "https://github.com/vim-test/vim-test" })

vim.g["test#strategy"] = "neovim_sticky"
vim.g["test#neovim#start_normal"] = 1
vim.g["test#preserve_screen"] = 0
vim.g["test#neovim_sticky#reopen_window"] = 1
vim.g["test#neovim_sticky#use_existing"] = 1

vim.cmd([[
  function! NexTestTransform(cmd) abort
    return substitute(a:cmd, '\(cargo nextest run\) ''\w\+::\(.\+\)\''', '\1 \2', '')
  endfunction
  let g:test#custom_transformations = {'nextest': function('NexTestTransform')}
  let g:test#transformation = 'nextest'
]])

local map = vim.keymap.set
map("n", "<leader>tt", "<cmd>wa | TestNearest<CR>", { desc = "Run nearest test" })
map("n", "<leader>tf", "<cmd>wa | TestFile<CR>", { desc = "Run file tests" })
map("n", "<leader>ta", "<cmd>wa | TestSuite<CR>", { desc = "Run all tests" })
map("n", "<leader>tl", "<cmd>wa | TestLast<CR>", { desc = "Run last test" })
map("n", "<leader>tv", "<cmd>wa | TestVisit<CR>", { desc = "Visit test file" })

-- Swift: Xcode projects use the custom `xcodetest` runner (autoload/test/swift/xcodetest.vim);
-- SwiftPM packages use vim-test's built-in runner, which needs the cwd at the Package.swift directory.
vim.g["test#custom_runners"] = { swift = { "XcodeTest" } }
vim.api.nvim_create_autocmd("FileType", {
  pattern = "swift",
  callback = function(ev)
    local name = vim.api.nvim_buf_get_name(ev.buf)
    local pkg = vim.fs.find("Package.swift", { path = name, upward = true })[1]
    if pkg then
      vim.g["test#project_root"] = vim.fs.dirname(pkg)
    else
      vim.g["test#project_root"] = vim.fn["test#swift#xcodetest#root"]
    end
  end,
})
