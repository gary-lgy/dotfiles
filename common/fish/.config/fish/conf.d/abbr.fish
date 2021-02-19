# Frequently used
abbr --global cp cp -i
abbr --global mv mv -i
abbr --global rm rm -i
abbr --global view nvim -R
abbr --global la ls -FAx
# abbr --global ll ls -lAhF

# cd
abbr --global -- - "cd - && ll"
abbr --global -- .. "cd .. && ll"
abbr --global -- ... "cd ../.. && ll"
abbr --global -- .... "cd ../../.. && ll"

# Git
abbr --global gb git branch
abbr --global gc git checkout
abbr --global gm git commit -m
abbr --global gd git diff
abbr --global gda git diff --cached
abbr --global gf git fetch
abbr --global gl git log --pretty=oneline -5
abbr --global gp git pull
abbr --global gpu git push -u origin HEAD
abbr --global gs git status

# Bundle
abbr --global be bundle exec
abbr --global bi bundle install

# Rails
abbr --global rc bundle exec rails c
abbr --global rs bundle exec rails s
abbr --global rk bundle exec rake
abbr --global rd bundle exec db:

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
