if !HasPlugin('editorconfig-vim')
  finish
endif

let g:EditorConfig_exclude_patterns = ['fugitive://.*']
