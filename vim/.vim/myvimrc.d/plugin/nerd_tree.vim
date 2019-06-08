" Close Vim if NERDTree is the only panel left
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Use <leader>n to toggle NERDTree
map <silent> <leader>n <Cmd>NERDTreeToggle<CR>
