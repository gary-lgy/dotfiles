" Enable tabline
let g:airline#extensions#tabline#enabled = 1

" Use powerline font
let g:airline_powerline_fonts = 1

" Use powerline and unicode symbols
let g:airline_left_sep                     = ''
let g:airline_left_alt_sep                 = ''
let g:airline_right_sep                    = ''
let g:airline_right_alt_sep                = ''
let g:airline#extensions#tabline#left_sep  = ''
let g:airline#extensions#tabline#right_sep = ''
if !exists("g:airline_symbols")
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch               = ''
let g:airline_symbols.readonly             = ''
let g:airline_symbols.linenr               = '¶'
let g:airline_symbols.maxlinenr            = ''
let g:airline_symbols.dirty                = '±'

" Theme
let g:airline_theme='deus'

" Configure tabline filename formatter
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Disable whitespace checking for certain filetypes
let g:airline#extensions#whitespace#skip_indent_check_ft = {
      \ 'go':       ['mixed-indent-file'],
      \ 'markdown': ['trailing']
      \}
