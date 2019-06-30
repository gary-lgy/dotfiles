" Mappings
" Jump and exchange
nnoremap <silent> cxh :SidewaysLeft<CR>
nnoremap <silent> cxl :SidewaysRight<CR>
nnoremap <silent> [s  :SidewaysJumpLeft<CR>
nnoremap <silent> ]s  :SidewaysJumpRight<CR>

" Argument text objects
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI
