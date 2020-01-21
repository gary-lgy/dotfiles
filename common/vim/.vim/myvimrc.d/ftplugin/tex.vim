setlocal spell

" Key bindings
nmap <buffer> <localleader>P :!pandoc -s --mathjax % -o %:r.

nmap <buffer> <localleader>i   <plug>(vimtex-info)
nmap <buffer> <localleader>I   <plug>(vimtex-info-full)
nmap <buffer> <localleader>h   <plug>(vimtex-toc-toggle)
nmap <buffer> <localleader>y   <plug>(vimtex-labels-toggle)
nmap <buffer> <localleader>v   <plug>(vimtex-view)
nmap <buffer> <localleader>r   <plug>(vimtex-reverse-search)
nmap <buffer> <localleader>l   <plug>(vimtex-compile)
nmap <buffer> <localleader>L   <plug>(vimtex-compile-toggle)
nmap <buffer> <localleader>k   <plug>(vimtex-stop)
nmap <buffer> <localleader>K   <plug>(vimtex-stop-all)
nmap <buffer> <localleader>e   <plug>(vimtex-errors)
nmap <buffer> <localleader>o   <plug>(vimtex-compile-output)
nmap <buffer> <localleader>g   <plug>(vimtex-status)
nmap <buffer> <localleader>G   <plug>(vimtex-status-all)
nmap <buffer> <localleader>c   <plug>(vimtex-clean)
nmap <buffer> <localleader>C   <plug>(vimtex-clean-full)
nmap <buffer> <localleader>m   <plug>(vimtex-imaps-list)
nmap <buffer> <localleader>x   <plug>(vimtex-reload)
nmap <buffer> <localleader>s   <plug>(vimtex-toggle-main)

nmap <buffer> dse              <plug>(vimtex-env-delete)
nmap <buffer> dsc              <plug>(vimtex-cmd-delete)
nmap <buffer> ds$              <plug>(vimtex-env-delete-math)
nmap <buffer> cse              <plug>(vimtex-env-change)
nmap <buffer> csc              <plug>(vimtex-cmd-change)
nmap <buffer> cs$              <plug>(vimtex-cmd-change-math)

nmap <buffer> <localleader>tse <plug>(vimtex-env-toggle-star)
nmap <buffer> <localleader>tsd <plug>(vimtex-delim-toggle-modifier)
xmap <buffer> <localleader>tsd <plug>(vimtex-delim-toggle-modifier)
nmap <buffer> <F7>             <plug>(vimtex-cmd-create)
imap <buffer> <F7>             <plug>(vimtex-cmd-create)
imap <buffer> ]]               <plug>(vimtex-delim-close)

" Text objects
let s:vimtex_textobjs = {
      \ 'ac': '<plug>(vimtex-ac)',
      \ 'ic': '<plug>(vimtex-ic)',
      \ 'ad': '<plug>(vimtex-ad)',
      \ 'id': '<plug>(vimtex-id)',
      \ 'ae': '<plug>(vimtex-ae)',
      \ 'ie': '<plug>(vimtex-ie)',
      \ 'a$': '<plug>(vimtex-a$)',
      \ 'i$': '<plug>(vimtex-i$)'
      \ }
let s:vimtex_motions = {
      \ 'gm': '<plug>(vimtex-%)',
      \ ']]': '<plug>(vimtex-]])',
      \ '][': '<plug>(vimtex-][)',
      \ '[]': '<plug>(vimtex-[])',
      \ '[[': '<plug>(vimtex-[[)'
      \ }

for key in keys(s:vimtex_textobjs)
  for mode in ['x', 'o']
    execute mode . 'map <buffer> ' . key ' ' . s:vimtex_textobjs[key]
  endfor
endfor

for key in keys(s:vimtex_motions)
  for mode in ['n', 'x', 'o']
    execute mode . 'map <buffer> ' . key ' ' . s:vimtex_motions[key]
  endfor
endfor

"Config
let g:vimtex_compiler_latexmk = {
      \ 'options' : [
      \   '-verbose',
      \   '-file-line-error',
      \   '-synctex=1',
      \   '-interaction=nonstopmode',
      \   '-latexoption=-shell-escape'
      \ ]
      \}
