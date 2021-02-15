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
let g:airline_symbols.linenr               = '' " '☰'
let g:airline_symbols.maxlinenr            = '' " ''
let g:airline_symbols.dirty                = '⚡'
let g:airline_symbols.crypt                = '🔒'
let g:airline_symbols.paste                = 'ρ'
let g:airline_symbols.spell                = 'Ꞩ'
let g:airline_symbols.notexists            = 'Ɇ'
let g:airline_symbols.whitespace           = 'Ξ'

" Theme
let g:airline_theme='deus'

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
      \ 'S'      : 'SL',
      \ ''     : 'SB',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'VL',
      \ ''     : 'VB',
      \ }

" Branch plugin
let g:airline#extensions#branch#displayed_head_limit = 15

" Tabline plugin
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" Configure tabline filename formatter
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Disable whitespace checking for certain filetypes
let g:airline#extensions#whitespace#skip_indent_check_ft = {
      \ 'go':       ['mixed-indent-file'],
      \ 'markdown': ['trailing']
      \}

" Override what to display for sections A and B for certain filetypes
if !exists("g:airline_filetype_overrides")
  let g:airline_filetype_overrides = {}
endif
let g:airline_filetype_overrides.Mundo = [ 'Mundo', '' ]
let g:airline_filetype_overrides.MundoDiff = [ 'MundoDiff', '' ]
let g:airline_filetype_overrides.vista = [ 'Vista', '' ]
let g:airline_filetype_overrides.vista_kind = g:airline_filetype_overrides.vista

" Do not display encoding if file is utf-8 encoded with unix line breaks
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" Display filename with path name if possible
let g:airline_section_c = '%{AirlineFilename()}'
function! AirlineFilename()
  let l:filename = substitute(expand('%'), $HOME, '~', '')
  if winwidth(0) < 90 || len(l:filename) > 50
    let l:filename = pathshorten(l:filename)
  endif
  return l:filename
endfunction
