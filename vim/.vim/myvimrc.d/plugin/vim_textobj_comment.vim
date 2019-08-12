if !HasPlugin('vim-textobj-comment')
  finish
endif

" Use custom mappings to avoid conflict with textobj-word-column
let g:textobj_comment_no_default_key_mappings = 1

" ax for 'around comment'
xmap ax <Plug>(textobj-comment-a)
omap ax <Plug>(textobj-comment-a)
" ix for 'inside comment'
xmap ix <Plug>(textobj-comment-i)
omap ix <Plug>(textobj-comment-i)
" Ax for 'around comment including trailing whitespace'
xmap Ax <Plug>(textobj-comment-big-a)
omap Ax <Plug>(textobj-comment-big-a)
