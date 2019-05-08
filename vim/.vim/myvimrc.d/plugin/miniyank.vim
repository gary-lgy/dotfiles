" Remap p
map p <Plug>(miniyank-autoput)=']
map P <Plug>(miniyank-autoPut)=']

" Mappings for cycling through the stack
if has('nvim')
  map <M-3> <Plug>(miniyank-cycle)
  map <M-4> <Plug>(miniyank-cycleback)
else
  map <Esc>3 <Plug>(miniyank-cycle)
  map <Esc>4 <Plug>(miniyank-cycleback)
endif

" Increase stack size
let g:miniyank_maxitems = 100
