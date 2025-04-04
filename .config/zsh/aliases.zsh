alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias configs='config status'
alias configtrackeddirs='config ls-tree --full-tree --name-only -r HEAD | rg -io "^[^/]+(/[^/]+)?" | sort -u'
alias configtracked='config ls-tree -r main --name-only'
alias cd='push_dir'
alias ls='ls --color=auto'
alias la='ls -lAh'
alias grep='grep --color=auto'
alias battery='cat /sys/class/power_supply/BAT0/capacity'
alias pacinstall='sudo pacman -Syu'
alias pacsearch='pacman -Ss'
alias pacnamesearch="pacman -Sl | cut -d' ' -f2- | rg"
alias yaynamesearch="yay -Sl | cut -d' ' -f2- | rg"
alias yay="yay --aur"
alias paccacheclear="paccache -rk1; paccache -ruk0; yay -Sc"
alias history='history 1'
alias gits='git status'
# alias gita='git add'
alias gitc='git commit -m'
alias gitd='git diff'
alias mariastart='sudo systemctl start mariadb.service'
alias mariastop='sudo systemctl stop mariadb.service'
alias mariastatus='systemctl status mariadb.service'
alias cdihome='cdi -d 3 ~/'
alias cdione="cdi --prune 'node_modules .classes .git target .settings .venv .images' ~/OneDrive"
alias btstart='sudo systemctl restart bluetooth.service'
alias btstop='sudo systemctl stop bluetooth.service'
alias btstatus='systemctl status bluetooth.service'
alias btctl='bluetoothctl'
alias btconnect='bluetoothctl connect'
alias downloads='cd ~/Downloads'
alias documents='cd ~/Documents'
alias compile-c='gcc -Wall --pedantic -fsanitize=address'
alias print_files="awk 'FNR==1{print \"\\n-----\", FILENAME, \"-----\"}1'"
alias docker='sudo docker'
alias dockerc='sudo docker container ls -as'
alias dockeri='sudo docker images'
alias dockerstart='sudo systemctl restart docker.service'
alias dockerstop='sudo systemctl stop docker.socket; sudo systemctl stop docker.service'
alias dockerstatus='systemctl status docker.service'
alias tr='trashy put'
alias rm='echo "Use trash!!!"'
alias npm='echo "Use pnpm!!!"'
alias pcalc='pcalc --colors'
alias gdb='tgdb'
alias less='less -FIRX'
alias aft-mtp-unmount='fusermount -u'
