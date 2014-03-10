# Path to your oh-my-zsh configuration.
ZSH=/home/matt/conf/oh-my-zsh

ZSH_THEME="yosemitebandit"

plugins=(
    git gitfast gitextras
    pip python
    history history-substring-search
    command-not-found
    common-aliases
    redis-cli
    screen
    ssh-agent
)

DISABLE_AUTO_UPDATE="true"
source $ZSH/oh-my-zsh.sh

# virtualenv wrapper setup
#source /usr/local/bin/virtualenvwrapper.sh
export WORKON_HOME=~/conf/envs

# Customize to your needs...
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/usr/X11/bin
export PATH=/usr/local/share/arduino/hardware/tools/avr/bin:/usr/local/share/arduino/hardware/tools:$PATH:/usr/local/share/openscad/bin

# add gcc-arm-none-eabi                                                        
export PATH=$PATH:/usr/local/share/gcc-arm-none-eabi-4_7-2012q4/bin            

# go support
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin

# go practice in the dir 'solid'
export GOPATH=$HOME/solid
export PATH=$PATH:$GOPATH/bin

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

    alias sai='sudo apt-get install'

    #{ git
        alias gs='git status --ignore-submodules=dirty'
        alias gh='git history'
        alias ga='git add'
        alias gb='git branch'
        alias gd='git diff --ignore-submodules=dirty'
        alias gcm='git commit -m'
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
#}
