
# zsh setup
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="af-magic"
zstyle ':omz:update' mode disabled  # disable auto updates
plugins=(
    autojump
    brew
    common-aliases
    git
    gitfast
    history
    ssh-agent
    tmux
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

# aliases
alias c='clear'
alias t='tree -C'
alias e='exit'
alias o='open'
alias ss='sudo $(fc -ln -1)'
alias tma='tmux attach-session -t'
alias tmls='tmux ls'
alias ht='htop'
alias rmr='rm -r'
alias rmrf='rm -rf'
alias py='python'
alias ag='ag --path-to-ignore=~/.agignore'
alias dss='docker stop -t 1'
alias gs='git status'
alias gcm='git commit -m'
alias gh='git history'
#alias gd='git-icdiff'
alias gpo='git push origin'
alias gop='git push origin'
alias gmm='git merge master'
alias gss='git stash save'
alias gsp='git stash pop'
alias ns='npm start'
alias nr='npm run'
alias gcma='git commit -am'

# remove things sans confirmation
unalias mv
unalias rm

# timestamped command history
alias history='fc -li -1000'
alias hgi='history | grep'

# fzf with rg
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# rust/cargo
export PATH=$HOME/.cargo/bin:$PATH

# lunarvim
export PATH=$HOME/.local/bin:$PATH

# mcfly
eval "$(mcfly init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#
# gcloud
#
# update PATH for the Google Cloud SDK.
if [ -f '/Users/matt/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/matt/google-cloud-sdk/path.zsh.inc'; fi
# enable shell command completion for gcloud.
if [ -f '/Users/matt/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/matt/google-cloud-sdk/completion.zsh.inc'; fi
# allow gcloud sdk to find grpcio in local site packages
export CLOUDSDK_PYTHON_SITEPACKAGES=1

# Android SDK
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin

export EDITOR='/usr/bin/vim -c "set wrap" -c "set textwidth=0"'

# thunderbug
alias nrtl='nr thunderbug list -- --folder inbox --track-replies'
