if !HasPlugin('sideways.vim')
  finish
endif

" Mappings
" Jump and exchange
nnoremap <silent> cxh :SidewaysLeft<CR>
nnoremap <silent> cxl :SidewaysRight<CR>
nnoremap <silent> [r  :SidewaysJumpLeft<CR>
nnoremap <silent> ]r  :SidewaysJumpRight<CR>

" Argument text objects
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI
