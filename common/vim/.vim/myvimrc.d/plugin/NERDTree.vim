if !HasPlugin('nerdtree')
  finish
endif

" Use <F7> to toggle NERDTree
nmap <F7> <Cmd>NERDTreeToggle<CR>
nmap <leader><F7> <Cmd>NERDTreeFind<CR>

" Use M to open menu
let g:NERDTreeMapMenu = 'M'
