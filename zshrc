
# zsh setup
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
zstyle ':omz:update' mode disabled  # disable auto updates
plugins=(
    common-aliases
    git
    gitfast
    history
    ssh-agent
)
source $ZSH/oh-my-zsh.sh

# right-aligned timestamp in the prompt
RPROMPT='%D{%L:%M %p}'
TMOUT=60
TRAPALRM() {
  zle reset-prompt
}

# do not create .pyc files.
export PYTHONDONTWRITEBYTECODE=1

# autojump
. /usr/share/autojump/autojump.sh

# aliases
alias c='clear'
alias t='tree -C'
alias e='exit'
alias o='open'
alias ss='sudo $(fc -ln -1)'
alias tma='tmux attach-session'
alias ht='htop'
alias rmr='rm -r'
alias rmrf='rm -rf'
alias py='python'
alias ag='ag --path-to-ignore=~/.agignore'
alias dss='docker stop -t 1'
alias gs='git status'
alias gh='git history'
alias gd='git-icdiff'
alias gpo='git push origin'
alias gmm='git merge master'
alias gss='git stash save'
alias gsp='git stash pop'

# remove things sans confirmation
unalias mv
unalias rm

# timestamped command history
alias history='fc -li -1000'
alias hgi='history | grep'
