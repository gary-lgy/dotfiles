if !HasPlugin('vim-tmux-navigator')
  finish
endif

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1
