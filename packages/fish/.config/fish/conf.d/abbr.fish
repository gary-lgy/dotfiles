# Frequently used
abbr --add cp cp -iv
abbr --add mv mv -iv
abbr --add rm rm -iv
abbr --add view nvim -R
abbr --add la ls -FAx
abbr --add rs rsync -auzvhP
# abbr --add ll ls -lAhF

# cd
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end

abbr --add dotdot --regex '^\.\.+$' --function multicd

# Brew
abbr --add bi "brew install"
abbr --add bic "brew install --cask"
abbr --add bu "brew uninstall"
abbr --add bp "brew update"
abbr --add bg "brew upgrade"
abbr --add bf "brew info"
abbr --add bs "brew search"

# Git
function gitlog
    set -l num_l (math (string length -- $argv[1]) - 1)
    echo git log --pretty=oneline -(math "$num_l * 10")
end

abbr --add ga git add
abbr --add gbc git branch -c
abbr --add gb git branch --sort=-committerdate
abbr --add gc git checkout
abbr --add gda git diff --cached
abbr --add gd git diff
abbr --add gf git fetch
abbr --add gitlog --regex '^gl+$' --function gitlog
abbr --add gman git commit --amend --no-edit
abbr --add gm git commit -m
abbr --add gp git pull
abbr --add gpu git push -u origin HEAD
abbr --add gri git rebase -i
abbr --add gs git status

# Tmux
abbr --add tl tmux ls
abbr --add ta tmux a -t
abbr --add tn tmux new -s

# Docker
abbr --add db docker build
abbr --add de docker exec
abbr --add di docker images
abbr --add dl docker logs
abbr --add dn docker network
abbr --add dp docker ps
abbr --add dr docker run
abbr --add ds docker stop
abbr --add dv docker volume
abbr --add dc docker-compose
abbr --add dcb docker-compose build
abbr --add dcd docker-compose down
abbr --add dcp docker-compose ps
abbr --add dcr docker-compose run
abbr --add dcu docker-compose up

# QMK
abbr --add qce qmk compile -kb ergodox_ez -km gary-lgy
abbr --add qfe qmk flash -kb ergodox_ez -km gary-lgy
abbr --add qcd qmk compile -kb handwired/dactyl_manuform/5x6 -km gary-lgy
abbr --add qfd qmk flash -kb handwired/dactyl_manuform/5x6 -km gary-lgy
