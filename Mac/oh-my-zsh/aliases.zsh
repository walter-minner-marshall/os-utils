# You can put files here to add functionality separated per file, which
# will be ignored by git.
# Files on the custom/ directory will be automatically loaded by the init
# script, in alphabetical order.

# For example: add yourself some shortcuts to projects you often work on.
#
# brainstormr=~/Projects/development/planetargon/brainstormr
# cd $brainstormr
G1_DATABASE=~/Dev/G1/g1-database
DOCKER_DB=~/Dev/G1/g1-svc-micro/g1-dev/docker-db
APP_EVENTS=~/Dev/G1/phx-app-events-web
TEESHEET=~/Dev/sites/dev.brsgolf.com
G1_MICRO_ROOT=~/Dev/G1/g1-svc-micro
G1_MAIN_ROOT=~/Dev/G1/g1-main
G1_ROOT=~/Dev/G1
OS_UTILS=~/Dev/os-utils

alias zshedit="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias reload="source ~/.zshrc"
alias tmsrc="source ~/.config/tmux/tmux.conf"

# Hosts
alias hosts='sudo nano //etc/hosts'

# Show Hide Hidden Files
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# Ping
alias ping='ping -c 3'

# Edit
#alias editbash='code ~/Dev/os-utils/Mac/oh-my-zsh/aliases.zsh'
alias editbash='code ~/Dev/os-utils/Mac/oh-my-zsh'

# Eza
alias ls='eza --icons'
alias ll='eza -la --icons --group-directories-first'        
alias la='eza -a --icons --group-directories-first'
alias l='eza -l --icons --group-directories-first'
alias lt='eza -T --icons --group-directories-first'
alias llt='eza -laT --icons --group-directories-first'
alias tree='eza --tree --icons --level=2 --group-directories-first'

###############################################
# Git
###############################################

# Git Paths
alias db="cd $G1_DATABASE"
alias appevents="cd $APP_EVENTS"
alias teesheet="cd $TEESHEET"
alias micro="cd $G1_MICRO_ROOT"
alias dockerdb="cd $DOCKER_DB"
alias main="cd $G1_MAIN_ROOT"
alias osutils="cd $OS_UTILS"

# Git Stashing
alias clearstash="git stash clear"
alias stash="git stash"
alias getstash="git stash apply"

# Git Branches
alias delbranch="git branch -D"

# Git Fetch
alias fetchdb="git fetch $G1_DATABASE -v"
alias fetchdbdry="git fetch $G1_DATABASE --dry-run -v"

##############################################
# Google Cloud SDK
##############################################
# G1 Pods
# alias pods='kubectl get pods'
# alias klogs='kubectl logs -f phx-api-app-events-7c9567f7b8-lc5qf'
# alias klogin='kubectl exec -it stage-app-events-mgo-1-667c67bbdf-2js8g -- /bin/bash'

# # The next line updates PATH for the Google Cloud SDK.
#  if [ -f '/usr/local/Caskroom/google-cloud-sdk/path.bash.inc' ]; then . '/usr/local/Caskroom/google-cloud-sdk/path.bash.inc'; fi

# # The next line enables shell command completion for gcloud.
#  if [ -f '/usr/local/Caskroom/google-cloud-sdk/completion.bash.inc' ]; then . '/usr/local/Caskroom/google-cloud-sdk/completion.bash.inc'; fi

###############################################
# Docker/Kubernetes
###############################################
#G1/BRS Teesheet

alias tsrun="cd $TEESHEET && make dev-run && cd -"
alias tsstop="cd $TEESHEET && make dev-stop && cd -"
alias tsclear="cd $TEESHEET && make dev-clear && cd -"

#G1 database

alias dbrun="cd $DOCKER_DB && docker-compose up -d && cd -"
alias dbstop="cd $DOCKER_DB && docker-compose down && cd -"
