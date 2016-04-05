# Path to your oh-my-zsh configuration.

if [[ "$MACHINE" == "work_laptop" ]]; then
  ZSH=/home/matt/conf/oh-my-zsh
  export EMAIL=matt.ball.2@gmail.com

elif [[ "$MACHINE" == "home" ]]; then
  ZSH=/home/matt/conf/oh-my-zsh
  export EMAIL=matt.ball.2@gmail.com

elif [[ "$MACHINE" == "mac" ]]; then
  ZSH=/Users/matt/conf/oh-my-zsh
  export EMAIL=matt.ball.2@gmail.com
  export TERM=xterm

else
  echo "remember to set MACHINE in .zshenv; it's currently: " $MACHINE
  ZSH=/home/matt/conf/oh-my-zsh
fi


ZSH_THEME="yosemitebandit"


plugins=(
    common-aliases
    django
    fabric
    git
    gitextras
    gitfast
    history
    history-substring-search
    lein
    npm
    pip
    pylint
    python
    ssh-agent
    sudo
    supervisor
    vagrant
)

DISABLE_AUTO_UPDATE="true"
source $ZSH/oh-my-zsh.sh

# go support
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/gocode

# heroku support
export PATH="/usr/local/heroku/bin:$PATH"

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

# Copy a file's contents to the clipboard.
# For mac: cat hallo.txt | pbcopy
if [[ ! "$MACHINE" == "mac" ]]; then
  alias copy='xclip -i -selection c'
fi

# Stop creating .pyc files.
export PYTHONDONTWRITEBYTECODE=1

#{ ALIASES
    alias ll='ls -la'
    alias la='ls -la'
    alias l='ls -lh'
    alias c='clear'
    alias cl='clear'
    alias t='tree -C'
    alias e='exit'
    alias ex='exit'
    alias sai='sudo apt-get install'
    alias o='open'
    alias ssn='echo "sudo shutdown now -P\n"; sudo shutdown now -P'
    alias pag='ps aux | grep'
    alias count-files='find . -type f | wc -l'
    alias cp='rsync -azh'

    # remove sans confirmation
    unalias mv
    unalias rm

    # use macvim on mac
    if [[ "$MACHINE" == "mac" ]]; then
        alias vi='mvim -v'
    fi

    # machine-dependent aliases
    if [[ ! "$MACHINE" == "mac" ]]; then
        alias open='xdg-open'

        if [[ "$MACHINE" == "work_laptop" ]]; then
            ssh-add ~/.ssh/endagaweb.pem
            ssh-add ~/.ssh/endaga-test.pem
            ssh-agent
            alias va='source ~/.virtualenvs/endaga-server/bin/activate'
            alias mr='echo "python manage.py runserver 0.0.0.0:8000\n"; python manage.py runserver 0.0.0.0:8000'
            alias mt='echo "python manage.py test --traceback\n"; cd ~/endaga-web; python manage.py test --traceback'
            alias mte='echo "python manage.py test endagaweb --traceback\n"; cd ~/endaga-web; python manage.py test endagaweb --traceback'
        fi

    fi

    # timestamped command history
    alias history='fc -li -1000'
    alias hgi='history | grep'

    #{ git
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
    #}

    #{ clojure
       alias lr='lein run'
       alias lt='lein test'
       alias lrl='lein repl'
    #}

    #{ vagrant
       alias vu='vagrant up'
       alias vh='vagrant halt'
       alias vs='vagrant ssh'
       alias vt='vagrant global-status'
       alias vsm='cd ~ && vagrant ssh mercury'
       alias vum='cd ~ && vagrant up mercury'
    #}

#}
