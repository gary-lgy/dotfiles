" My filetype and plugin configurations
set runtimepath^=~/.vim/myvimrc.d

" Initialize vim plug
source ~/.vim/myvimrc.d/vim_plug.vim

" My general configurations and key bindings
set runtimepath+=~/.vim/myvimrc.d/after
runtime! myvimrc.d/after/*.vim
