" Spell checking
setlocal spell spelllang=en_us

" Soft word wrap (good for prose)
setlocal wrap
setlocal linebreak
setlocal breakindent

" Inline rendering: hide syntax markers (**bold**, *italic*, links)
setlocal conceallevel=2
setlocal concealcursor=nc

" Navigate wrapped lines naturally
nnoremap <buffer> j gj
nnoremap <buffer> k gk

" Jump between headings with ]] and [[
nnoremap <buffer> ]] :<C-u>call search('^#', 'W')<CR>
nnoremap <buffer> [[ :<C-u>call search('^#', 'bW')<CR>

" Code
let g:markdown_fenced_languages = ['python', 'javascript', 'typescript', 'bash', 'lua', 'html', 'json', 'yaml', 'dart', 'rust']
