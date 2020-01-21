if !HasPlugin('switch.vim')
  finish
endif

" Bind the key myself to allow vim-plug to lazily load the plugin
let g:switch_mapping = ""

nnoremap <silent> gs :Switch<CR>

" Custom definitions
let g:switch_custom_definitions =
    \ [
    \   ['public', 'private', 'protected'],
    \   ['if', 'unless'],
    \   ['true', 'false'],
    \   ['>=', '<'],
    \   ['<=', '>']
    \ ]

autocmd FileType tex let b:switch_custom_definitions =
      \ [
      \   ['\\land', '\\lor']
      \ ]
