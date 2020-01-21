if !HasPlugin('clever-f.vim')
  finish
endif

" Continue to use ' and , 
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)

" f always searches forward, F always searched backwards
let g:clever_f_fix_key_direction = 1
