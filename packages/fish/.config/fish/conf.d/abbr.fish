# Frequently used
abbr --global cp cp -iv
abbr --global mv mv -iv
abbr --global rm rm -iv
abbr --global view nvim -R
abbr --global la ls -FAx
abbr --global rs rsync -auzvhP
# abbr --global ll ls -lAhF

# cd
abbr --global -- - "cd - && l"
abbr --global -- .. "cd .. && l"
abbr --global -- ... "cd ../.. && l"
abbr --global -- .... "cd ../../.. && l"

# Brew
abbr --global bi "brew install"
abbr --global bic "brew install --cask"
abbr --global bu "brew uninstall"
abbr --global bp "brew update"
abbr --global bg "brew upgrade"
abbr --global bf "brew info"
abbr --global bs "brew search"

# Git
abbr --global ga git add
abbr --global gb git branch
abbr --global gc git checkout
abbr --global gm git commit -m
abbr --global gd git diff
abbr --global gda git diff --cached
abbr --global gf git fetch
abbr --global gl git log --pretty=oneline -10
abbr --global gp git pull
abbr --global gpu git push -u origin HEAD
abbr --global gs git status

# Tmux
abbr --global tl tmux ls
abbr --global ta tmux a -t
abbr --global tn tmux new -s

# Docker
abbr --global db docker build
abbr --global de docker exec
abbr --global di docker images
abbr --global dl docker logs
abbr --global dn docker network
abbr --global dp docker ps
abbr --global dr docker run
abbr --global ds docker stop
abbr --global dv docker volume
abbr --global dc docker-compose
abbr --global dcb docker-compose build
abbr --global dcd docker-compose down
abbr --global dcp docker-compose ps
abbr --global dcr docker-compose run
abbr --global dcu docker-compose up

# QMK
abbr --global qce qmk compile -kb ergodox_ez -km gary-lgy
abbr --global qfe qmk flash -kb ergodox_ez -km gary-lgy
abbr --global qcd qmk compile -kb handwired/dactyl_manuform/5x6 -km gary-lgy
abbr --global qfd qmk flash -kb handwired/dactyl_manuform/5x6 -km gary-lgy
