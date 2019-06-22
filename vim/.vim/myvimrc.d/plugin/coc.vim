" Extensions
" TODO: let vim-plug manage extensions
" TODO: consider replacing fzf with coc-list
" TODO: coc-ccls is not ready for use yet
let g:coc_global_extensions = [
      \ 'coc-lists',
      \ 'coc-tsserver',
      \ 'coc-eslint',
      \ 'coc-prettier',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-json',
      \ 'coc-python',
      \ 'coc-solargraph',
      \ 'coc-vimlsp',
      \ 'coc-highlight',
      \ 'coc-diagnostic',
      \ 'coc-word',
      \ 'coc-import-cost',
      \ 'coc-yank'
      \]

" Core functionalities{{{

" Use <M-c> to trigger completion
inoremap <silent><expr> <M-c> coc#refresh()

" Code nagivation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Rename
nmap <leader>rn <Plug>(coc-rename)

" Code Action
" On a text object
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)

" On current line
nmap <leader>caa  <Plug>(coc-codeaction)

"}}}

" Miscellaneous functionalities{{{

" Use Alt+k to show documentation in preview window
nnoremap <silent> <M-k> :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
highlight default CocHighlightText guibg=#555555  ctermbg=223

"}}}

" CocList keybindings{{{

" Show all diagnostics
nnoremap <silent> <leader>cd  :CocList --normal diagnostics<CR>
" Show commands
nnoremap <silent> <leader>cc  :CocList commands<CR>
" Show outline of current file
nnoremap <silent> <leader>co  :CocList outline<CR>
" Search workspace symbols
nnoremap <silent> <leader>cs  :CocList -I symbols<CR>

"}}}

" coc-yank{{{

" Open yank list
nnoremap <silent> <leader>cy  :<C-u>CocList --normal yank<CR>

"}}}
