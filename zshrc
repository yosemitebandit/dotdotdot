# Path to your oh-my-zsh configuration.

if [[ "$MACHINE" == "work_desktop" ]]; then
  ZSH=/usr/local/google/home/matthewball/conf/oh-my-zsh
  # g4d alias has to be run at the end of this file.. :/
  export GITCONFIG_EMAIL_ADDRESS=matthewball@google.com
  alias hreview='/usr/local/google/home/matthewball/Quad/tools/code_review/hreview.py'
  # ccache
  if [[ -d /usr/lib/ccache && ${PATH/*ccache*/FOUND} != FOUND ]]; then  export PATH=/usr/lib/ccache:${PATH}
  fi
elif [[ "$MACHINE" == "work_laptop" ]]; then
  ZSH=/home/matthewball/conf/oh-my-zsh
  export GITCONFIG_EMAIL_ADDRESS=matthewball@google.com
  alias hreview='/home/matthewball/Quad/tools/code_review/hreview.py'
  # ccache
  if [[ -d /usr/lib/ccache && ${PATH/*ccache*/FOUND} != FOUND ]]; then  export PATH=/usr/lib/ccache:${PATH}
  fi
elif [[ "$MACHINE" == "home" ]]; then
  ZSH=/Users/matt/conf/djan/oh-my-zsh
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
    redis-cli
    screen
    ssh-agent
)

DISABLE_AUTO_UPDATE="true"
source $ZSH/oh-my-zsh.sh

# customized paths
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/usr/X11/bin
export PATH=/usr/local/share/arduino/hardware/tools/avr/bin:/usr/local/share/arduino/hardware/tools:$PATH:/usr/local/share/openscad/bin

# add gcc-arm-none-eabi
export PATH=$PATH:/usr/local/share/gcc-arm-none-eabi-4_7-2012q4/bin

# go support
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/gocode

# setup editor for piper
export EDITOR='vi'

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

    #{ git
        alias gs='git status --ignore-submodules=dirty'
        alias gh='git history'
        alias ga='git add'
        alias gb='git branch'
        alias gd='git diff --ignore-submodules=dirty'
        alias gcm='git commit -m'
        alias gco='git checkout'
        alias gf='git fetch'
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
       alias gpyl='gpylint -d g-space-before-docstring-summary,g-no-space-after-docstring-summary'
       alias nd='nosetests -d'
       alias py='python'
    #}
#}


# this use of autocompletion has to happen at the end of the file for some reason :/
if [[ "$MACHINE" == "work_desktop" ]]; then
  source /etc/bash_completion.d/g4d  # g4d alias
fi