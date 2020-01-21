if !HasPlugin('markdown-preview.nvim')
  finish
endif

" Specify browser to open preview page
let g:mkdp_browser = $BROWSER
