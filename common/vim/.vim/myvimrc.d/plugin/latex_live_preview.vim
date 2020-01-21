if !HasPlugin('vim-latex-live-preview')
  finish
endif

let g:livepreview_previewer = 'zathura'
let g:livepreview_cursorhold_recompile = 0
