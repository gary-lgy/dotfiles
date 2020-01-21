" Prevent other plugins from interfering
" Disable indent guides
silent! :IndentGuidesDisable

" Disable >p and <p key bindings from unimpaired.vim
silent! unmap <p
silent! unmap >p
silent! unmap <P
silent! unmap >P

" Disable vim-test mappings
silent! unmap t<C-F>
silent! unmap t<C-L>
silent! unmap t<C-G>
silent! unmap t<C-S>
silent! unmap t<C-N>

" Options
let g:calendar_first_day = 'sunday'
