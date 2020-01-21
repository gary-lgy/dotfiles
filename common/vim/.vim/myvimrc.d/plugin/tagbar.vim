if !HasPlugin('tagbar')
  finish
endif

" Key-binding
nmap <silent> <F8> :TagbarToggle<CR>

" Options
let g:tagbar_sort = 0
let g:tagbar_show_linenumbers = 1
let g:tagbar_singleclick = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_foldlevel = 2
