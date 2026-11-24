" vim-test runner for Xcode projects (no Package.swift): runs xcodebuild with -only-testing.
" Test targets are directories named like `fooTests` / `fooUITests` holding XCTestCase classes.
let s:file_pattern = '\v%(^|/)(\w+%(Tests))/.*\.swift$'

function! test#swift#xcodetest#test_file(file) abort
  return a:file =~# s:file_pattern && !empty(s:xcodeproj())
endfunction

function! test#swift#xcodetest#build_position(type, position) abort
  if a:type ==# 'suite'
    return []
  endif
  let l:target = matchlist(a:position['file'], s:file_pattern)[1]
  let l:id = l:target
  let l:class = s:parse_class(a:position['file'])
  if !empty(l:class)
    let l:id .= '/' . l:class
    if a:type ==# 'nearest'
      let l:nearest = join(test#base#nearest_test(a:position, g:test#swift#patterns)['test'])
      if !empty(l:nearest)
        let l:id .= '/' . l:nearest
      endif
    endif
  endif
  return ['-only-testing:' . l:id]
endfunction

function! test#swift#xcodetest#build_args(args) abort
  let l:proj = s:xcodeproj()
  let l:scheme = fnamemodify(l:proj, ':t:r')
  return ['test', '-project', l:proj, '-scheme', l:scheme, '-destination', "'platform=macOS'"] + a:args
endfunction

function! test#swift#xcodetest#executable() abort
  return 'xcodebuild'
endfunction

function! s:parse_class(file) abort
  for l:line in getbufline(a:file, 1, '$')
    let l:m = matchlist(l:line, g:test#swift#patterns['namespace'][0])
    if !empty(l:m)
      return l:m[1]
    endif
  endfor
  return ''
endfunction

" Nearest *.xcodeproj directory, searching upward from the current file.
function! s:xcodeproj() abort
  let l:found = globpath(escape(s:root(), ' ,'), '*.xcodeproj', 0, 1)
  return empty(l:found) ? '' : fnamemodify(l:found[0], ':t')
endfunction

function! s:root() abort
  let l:dir = expand('%:p:h')
  while l:dir !=# '/' && empty(globpath(escape(l:dir, ' ,'), '*.xcodeproj', 0, 1))
    let l:dir = fnamemodify(l:dir, ':h')
  endwhile
  return l:dir
endfunction

function! test#swift#xcodetest#root() abort
  return s:root()
endfunction
