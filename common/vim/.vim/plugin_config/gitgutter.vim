" Set gitgutter refresh rate
set updatetime=100

" Set sign appearance
highlight! link GitGutterAdd DiffAdd
highlight! link GitGutterChange DiffChange
highlight! link GitGutterChangeDelete DiffChange
highlight! link GitGutterDelete DiffDelete

" Turn off default key mappings
let g:gitgutter_map_keys = 0

" Define custom key mappings
nmap ]h         <Plug>(GitGutterNextHunk)
nmap [h         <Plug>(GitGutterPrevHunk)
nmap <Leader>ha <Plug>(GitGutterStageHunk)
nmap <Leader>hr <Plug>(GitGutterUndoHunk)
nmap <Leader>hv <Plug>(GitGutterPreviewHunk)
omap ih         <Plug>(GitGutterTextObjectInnerPending)
omap ah         <Plug>(GitGutterTextObjectOuterPending)
xmap ih         <Plug>(GitGutterTextObjectInnerVisual)
xmap ah         <Plug>(GitGutterTextObjectOuterVisual)
