# https://unix.stackexchange.com/questions/119/colors-in-man-pages
set -x LESS_TERMCAP_md (printf "\e[0;35m")
set -x LESS_TERMCAP_me (printf "\e[0m")
set -x LESS_TERMCAP_se (printf "\e[0m")
set -x LESS_TERMCAP_so (printf "\e[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\e[0m")
set -x LESS_TERMCAP_us (printf "\e[01;32m")
set -x GROFF_NO_SGR 1 # required for tmux
