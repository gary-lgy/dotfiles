if !HasPlugin('coc.nvim')
  finish
endif

" Use global node executable
let g:coc_node_path = '/usr/bin/node'

" Extensions
" TODO: coc-ccls is not ready for use yet
let g:coc_global_extensions = [
      \ 'coc-lists',
      \ 'coc-marketplace',
      \ 'coc-tsserver',
      \ 'coc-eslint',
      \ 'coc-prettier',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-json',
      \ 'coc-python',
      \ 'coc-solargraph',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ 'coc-sh',
      \ 'coc-vimtex',
      \ 'coc-import-cost',
      \ 'coc-highlight',
      \ 'coc-word',
      \ 'coc-syntax',
      \ 'coc-tag',
      \ 'coc-ultisnips'
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
nmap <leader>cr <Plug>(coc-rename)

" Format
command! -nargs=0 Format :call CocAction('format')
cabbrev F Format

" Organise imports
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" CodeActions
nmap <leader>ca :CocList actions<CR>

" codeLens
nmap <leader>cl <Plug>(coc-codelens-action)

" Signature hint
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

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
