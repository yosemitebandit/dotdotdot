# Path to your oh-my-zsh configuration.

if [[ "$MACHINE" == "work_desktop" ]]; then
  ZSH=/usr/local/google/home/matthewball/conf/oh-my-zsh
  # g4d alias has to be run at the end of this file.. :/
  export GITCONFIG_EMAIL_ADDRESS=matthewball@google.com
  # setup editor for piper
  export EDITOR='vi'
  alias g4p='g4 pending'
  alias g5='git5'

elif [[ "$MACHINE" == "work_laptop" ]]; then
  ZSH=/home/matthewball/conf/oh-my-zsh
  export GITCONFIG_EMAIL_ADDRESS=matthewball@google.com

elif [[ "$MACHINE" == "home" ]]; then
  ZSH=/home/matt/conf/oh-my-zsh
  export GITCONFIG_EMAIL_ADDRESS=matt.ball.2@gmail.com

elif [[ "$MACHINE" == "mac" ]]; then
  ZSH=/Users/matt/conf/oh-my-zsh
  export GITCONFIG_EMAIL_ADDRESS=matt.ball.2@gmail.com
  export TERM=xterm

else
  echo "remember to set MACHINE in .zshenv; it's currently: " $MACHINE
  ZSH=/home/matt/conf/oh-my-zsh
fi

ZSH_THEME="yosemitebandit"

plugins=(
    git gitfast gitextras
    pip python
    history history-substring-search
    common-aliases
    ssh-agent
)

DISABLE_AUTO_UPDATE="true"
source $ZSH/oh-my-zsh.sh

# go support
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/gocode

# history search matching entire line
# http://superuser.com/questions/417627/oh-my-zsh-history-completion
bindkey '^[OA' history-beginning-search-backward
bindkey '^[OB' history-beginning-search-forward

#{ ALIASES
    alias ll='ls -la'
    alias la='ls -la'
    alias l='ls -lh'
    
    alias open='xdg-open'

    alias c='clear'
    alias cl='clear'

    alias t='tree -C'

    alias e='exit'
    alias ex='exit'

    alias sai='sudo apt-get install'

    alias hgr='history | grep'

    alias lr='lein run'

    #{ git
        alias gs='git status --ignore-submodules=dirty'
        alias gh='git history'
        alias ga='git add'
        alias gb='git branch'
        alias gd='git diff --ignore-submodules=dirty'
        alias gcm='git commit -m'
        alias gco='git checkout'
        alias gf='git fetch'
        alias gcam='git commit -am'
        alias gacm='git commit -am'
    #}
    
    #{ ino
        alias ic='ino clean'
        alias ib='ino build'
        alias iu='ino upload'
        alias is='ino serial'
        alias icbu='ino clean && ino build && ino upload'
        alias icbus='ino clean && ino build && ino upload && ino serial'
        alias ius='ino upload && ino serial'
    #}

    #{ python
       alias py='python'
       alias nd='nosetests -d'
       alias pyl='pylint --report=n'
       alias gpyl='gpylint -d g-space-before-docstring-summary,g-no-space-after-docstring-summary'
    #}
#}


# this use of autocompletion has to happen at the end of the file for some reason :/
if [[ "$MACHINE" == "work_desktop" ]]; then
  source /etc/bash_completion.d/g4d  # g4d alias
fi
