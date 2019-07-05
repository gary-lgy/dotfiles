if !HasPlugin('vim-airline')
  finish
endif

" Enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" Fast buffer nagivation
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

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
let g:airline_symbols.linenr               = '☰'
let g:airline_symbols.maxlinenr            = ''
let g:airline_symbols.dirty                = '⚡'
let g:airline_symbols.crypt                = '🔒'
let g:airline_symbols.paste                = 'ρ'
let g:airline_symbols.spell                = 'Ꞩ'
let g:airline_symbols.notexists            = 'Ɇ'
let g:airline_symbols.whitespace           = 'Ξ'

" Theme
let g:airline_theme='deus'

" Configure tabline filename formatter
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Disable whitespace checking for certain filetypes
let g:airline#extensions#whitespace#skip_indent_check_ft = {
      \ 'go':       ['mixed-indent-file'],
      \ 'markdown': ['trailing']
      \}

" Use shortform for mode names
let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ ''     : 'S',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ ''     : 'V',
      \ }
