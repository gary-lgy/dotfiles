if !HasPlugin('editorconfig-vim')
  finish
endif

let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']
