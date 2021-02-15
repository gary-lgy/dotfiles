" Disable unused shortcuts
let g:AutoPairsShortcutToggle     = ''
let g:AutoPairsShortcutBackInsert = ''
let g:AutoPairsShortcutJump       = ''
let g:AutoPairsShortcutFastWrap   = ''

" Disable multi-line auto-close
let g:AutoPairsMultilineClose = 0

autocmd Filetype tex let b:AutoPairs = AutoPairsDefine({
      \ "$$": "$$",
      \ "$": "$"
      \ })
autocmd Filetype vim let b:AutoPairs = AutoPairsDefine({}, ["\""])
