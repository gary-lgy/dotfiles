if !HasPlugin('nerdcommenter')
  finish
endif

filetype plugin on

let g:NERDSpaceDelims = 1

let g:NERDCompactSexyComs = 1

let g:NERDDefaultAlign = 'left'

let g:NREDAltDelims_java = 1

let g:NERDCustomDelimiters = { 'python': { 'left': '#', 'right': '' } }

let g:NERDTrimTrailingWhitespace = 1

let g:NERDToggleCheckAllLines = 1
