if !HasPlugin('vim-indent-guides')
  finish
endif

" Enable indent guides on vim startup.
let g:indent_guides_enable_on_vim_startup = 1

" Start highlighting from second level onwards.
let g:indent_guides_start_level = 2

" Make guide size 1-character wide.
let g:indent_guides_guide_size = 1

" Disable intent guides in some scenarios
autocmd FileType calendar,vimwiki,markdown IndentGuidesDisable
