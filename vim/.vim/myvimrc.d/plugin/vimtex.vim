if !HasPlugin('vimtex')
  finish
endif

let g:vimtex_mappings_enabled = 0

let g:vimtex_indent_lists = [
      \ 'itemize',
      \ 'description',
      \ 'enumerate',
      \ 'thebibliography',
      \ 'compactenum',
      \ 'compactitem'
      \]
