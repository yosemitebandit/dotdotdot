# Path to your oh-my-zsh configuration.

ZSH=/home/matt/.oh-my-zsh
#ZSH_THEME="intheloop"


plugins=(
  common-aliases
  git
  gitextras
  gitfast
  history
  history-substring-search
  ssh-agent
)


DISABLE_AUTO_UPDATE="true"
source $ZSH/oh-my-zsh.sh


# history search matching entire line
# http://superuser.com/questions/417627/oh-my-zsh-history-completion
bindkey '^[OA' history-beginning-search-backward
bindkey '^[OB' history-beginning-search-forward


# right-aligned timestamp in the prompt
RPROMPT='%D{%L:%M %p}'
TMOUT=60
TRAPALRM() {
  zle reset-prompt
}


# Stop creating .pyc files.
export PYTHONDONTWRITEBYTECODE=1


# Various aliases.
alias ll='ls -la'
alias la='ls -la'
alias l='ls -lh'
alias c='clear'
alias cl='clear'
alias t='tree -C'
alias e='exit'
alias ex='exit'
alias sau='echo "sudo apt update\n" sudo apt update'
alias sagu='echo "sudo apt update\n" sudo apt update'
alias sai='sudo apt install'
alias sagi='sudo apt install'
alias open='xdg-open'
alias o='xdg-open'
alias ssn='echo "sudo shutdown now -P\n"; sudo shutdown now -P'
alias pag='ps aux | grep'
alias count-files='find . -type f | wc -l'
alias ss='sudo $(fc -ln -1)'
alias tma='tmux attach-session'
alias ht='htop'
alias rmr='rm -r'
alias rmrf='rm -rf'


# remove things sans confirmation
unalias mv
unalias rm


# timestamped command history
alias history='fc -li -1000'
alias hgi='history | grep'


# git-related aliases
alias gs='git status --ignore-submodules=dirty'
alias gsd='gs'
alias gh='git history'
alias ga='git add'
alias gb='git branch'
alias gd='git-icdiff'
alias gcm='git commit -m'
alias gco='git checkout'
alias gf='git fetch'
alias gcam='git commit -am'
alias gacm='git commit -am'
alias gcma='git commit -am'
alias gbg='git branch | grep'
alias gpo='git push origin'
alias glo='git pull origin'
alias gmm='git merge master'
alias gld='git log --full-diff -p .'
alias gss='git stash save'
alias gsp='git stash pop'



# python-related aliases
alias py='python'
alias pt='py.test'
alias ptq='py.test -q'
alias pla='pylama'
alias pyshs='python -m SimpleHTTPServer'
alias pshs='python -m SimpleHTTPServer'
alias jk='py.test -q && pylama'


# neovim-related aliases
alias nv='nvim'


# aliases for my blog -- write a new post and start a local server
function hnt() {
 source ~/conf/virtualenvs/vebsite/bin/activate
 hugo new notes/"$@".md;
}
function hs() {
 source ~/conf/virtualenvs/vebsite/bin/activate
 hugo server --port=8000 --watch --disableLiveReload --preserveTaxonomyNames
}


#{ adding paths
function append-to-path() {
 export PATH=$PATH:"$@";
}


# the silver searcher
alias ag='ag --path-to-ignore=~/.agignore'


# docker
alias ds='docker stop -t 1'


# sshing into ec2
function ec2ssh() {
 ssh -i ~/.ssh/matt.pem ubuntu@"$@"
}


# load autojump
source /usr/share/autojump/autojump.sh


# Setup spaceship theme.
source "/home/matt/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
SPACESHIP_DIR_COLOR="green"
SPACESHIP_TIME_SHOW="false"
SPACESHIP_GIT_BRANCH_COLOR="blue"
SPACESHIP_GIT_BRANCH_PREFIX=""
SPACESHIP_GIT_STATUS_COLOR="red"
SPACESHIP_DOCKER_SHOW="false"
