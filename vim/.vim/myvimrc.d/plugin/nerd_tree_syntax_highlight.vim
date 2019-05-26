" " Highlight full name without vim-devicons
" let g:NERDTreeFileExtensionHighlightFullName = 1
" let g:NERDTreeExactMatchHighlightFullName    = 1
" let g:NERDTreePatternMatchHighlightFullName  = 1

" Highlight folders using exact match
let g:NERDTreeHighlightFolders               = 1
let g:NERDTreeHighlightFoldersFullName       = 1

" Customise colors
let s:brown       = "905532"
let s:aqua        = "3AFFDB"
let s:blue        = "689FB6"
let s:darkBlue    = "44788E"
let s:purple      = "834F79"
let s:lightPurple = "834F79"
let s:red         = "AE403F"
let s:beige       = "F5C06F"
let s:yellow      = "F09F17"
let s:orange      = "D4843E"
let s:darkOrange  = "F16529"
let s:pink        = "CB6F6F"
let s:salmon      = "EE6E73"
let s:green       = "8FAA54"
let s:lightGreen  = "31B53E"
let s:white       = "FFFFFF"
let s:rspec_red   = 'FE405F'
let s:git_orange  = 'F54D27'

let g:NERDTreeExtensionHighlightColor         = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['html'] = s:darkBlue
let g:NERDTreeExtensionHighlightColor['css']  = s:pink
let g:NERDTreeExtensionHighlightColor['sass'] = s:pink
let g:NERDTreeExtensionHighlightColor['js']   = s:beige
let g:NERDTreeExtensionHighlightColor['json'] = s:beige
let g:NERDTreeExtensionHighlightColor['c']    = s:orange
let g:NERDTreeExtensionHighlightColor['cpp']  = s:orange
let g:NERDTreeExtensionHighlightColor['py']   = s:aqua
let g:NERDTreeExtensionHighlightColor['java'] = s:lightPurple
let g:NERDTreeExtensionHighlightColor['bash'] = s:lightGreen
let g:NERDTreeExtensionHighlightColor['sh']   = s:lightGreen
let g:NERDTreeExtensionHighlightColor['rb']   = s:red
let g:NERDTreeExtensionHighlightColor['erb']  = s:red
let g:NERDTreeExtensionHighlightColor['md']   = s:white
let g:NERDTreeExtensionHighlightColor['tex']  = s:white
