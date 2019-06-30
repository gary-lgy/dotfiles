" Use custom mappings to avoid conflict with textobj-word-column
let g:textobj_comment_no_default_key_mappings = 1

" a/ for 'around comment'
xmap a/ <Plug>(textobj-comment-a)
omap a/ <Plug>(textobj-comment-a)
" i/ for 'inside comment'
xmap i/ <Plug>(textobj-comment-i)
omap i/ <Plug>(textobj-comment-i)
" A/ for 'around comment including trailing whitespace'
xmap A/ <Plug>(textobj-comment-big-a)
omap A/ <Plug>(textobj-comment-big-a)
