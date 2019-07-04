" Use rg for search
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

nmap <leader>g :Ack<space>

" Use dispatch to launch searches
if !empty(glob('~/.vim/plugged/vim-dispatch'))
  let g:ack_use_dispatch = 1
endif
