" Use rg for search
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

nmap <leader>g :Ack<space>
