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
  export TERM=xterm-256color

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

# rust
# Use the "append-to-path" function below to work with the various multirust toolchains.
export PATH=$PATH:~/.cargo/bin

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

if [[ "$MACHINE" == "mac" ]]; then
  source '/Users/matt/archive/google-cloud-sdk/path.zsh.inc'
  source '/Users/matt/archive/google-cloud-sdk/completion.zsh.inc'
fi

#{ ALIASES
    alias ll='ls -la'
    alias la='ls -la'
    alias l='ls -lh'
    alias c='clear'
    alias cl='clear'
    alias t='tree -C'
    alias e='exit'
    alias ex='exit'
    alias sau='echo "sudo apt-get update\n" sudo apt-get update'
    alias sagu='echo "sudo apt-get update\n" sudo apt-get update'
    alias sai='sudo apt-get install'
    alias sagi='sudo apt-get install'
    alias o='open'
    alias ssn='echo "sudo shutdown now -P\n"; sudo shutdown now -P'
    alias pag='ps aux | grep'
    alias count-files='find . -type f | wc -l'
    alias cp='rsync -azh'
    alias ss='sudo $(fc -ln -1)'
    alias tma='tmux attach-session'
    alias ht='htop'
    alias rmr='rm -r'

    # remove things sans confirmation
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
       alias pt='py.test'
       alias ptq='py.test -q'
       alias pla='pylama'
       alias pyshs='python -m SimpleHTTPServer'
       alias pshs='python -m SimpleHTTPServer'
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

    #{ rust
       alias cb='cargo build'
       alias ct='cargo test'
       alias cr='cargo run'
       alias ccc='cargo clean'
       alias re='rustc --explain'
       alias rce='rustc --explain'
    #}

    #{ neovim
       alias nv='nvim'
    #}

    #{ my blog
       # Write a new post.
       function hnt() {
         source ~/conf/virtualenvs/vebsite/bin/activate
         hugo new notes/"$@".md;
       }
       # Start the local server.
       function hs() {
         source ~/conf/virtualenvs/vebsite/bin/activate
         hugo server --port=8000 --watch --disableLiveReload --preserveTaxonomyNames
       }
    #}

    #{ adding paths
       function append-to-path() {
         export PATH=$PATH:"$@";
       }
    #}

    #{ gae
       alias da='dev_appserver.py ./'
       alias au='appcfg.py update ./'
       alias aut='appcfg.py update tour.yaml'
    #}
#}
