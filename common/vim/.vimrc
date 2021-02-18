" Leader keys
" Run these before loading plugins so that any plugin that maps to <leader> will use the updated leader key
let mapleader = ' '
let maplocalleader = '  '

" Load the plugins
source ~/.vim/vim_plug.vim
" All the plugins have been loaded

" Load more config, potentially overwriting config from plugins
" These config can also use anything defined by the plugins
source ~/.vim/options.vim
source ~/.vim/keys.vim
