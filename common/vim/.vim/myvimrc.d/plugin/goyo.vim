if !HasPlugin('goyo.vim')
  finish
endif

" Workaround to prevent airline from refreshing itself
if HasPlugin('vim-airline')
  autocmd User GoyoEnter nested set eventignore=FocusGained
  autocmd User GoyoLeave nested set eventignore=
endif
