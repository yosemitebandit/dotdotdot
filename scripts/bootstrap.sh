#!/usr/bin/env bash
# bootstrapping a new ubuntu machine with my dotfiles
# github.com/yosemitebandit/dotdotdot
#
# $ bootstrap.sh <machine> <email>

# ---
# go no further if we're not with user 'matt'
# ---
if [! id -u matt >/dev/null 2>&1]; then
  echo "sorry, you need to make a 'matt' user first"
  echo "probably via 'sudo adduser matt && sudo usermod -a -G sudo matt'"
  exit 1
fi

# ---
# apt - upgrades, vim, python, ack
# ---
echo "apt!"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get -y install git-core git-gui gitk zsh vim-gtk exuberant-ctags \
                        mercurial cmake python-dev software-properties-common \
                        python-software-properties python-pip python-dev \
                        python-virtualenv build-essential gfortran \
                        libopenblas-dev liblapack-dev libfreetype6-dev \
                        libpng-dev ack-grep openjdk-7-jdk
sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
# add-apt-repo may not be available until after first upgrade
sudo add-apt-repository ppa:nmi/vim-snapshots -y
sudo apt-get update -y
sudo apt-get upgrade -y


# ---
# ssh keys
# ---
if [ ! -e ~/.ssh/id_rsa.pub ]; then
  echo "ssh keys!"
  echo "creating ssh keys with email '$2'"
  ssh-keygen -t rsa -C "$2" -N "" -f ~/.ssh/id_rsa
  echo "add this public key to github:"
  cat ~/.ssh/id_rsa.pub
fi


# ---
# zsh
# ---
echo "zsh!"
if [ ! $SHELL == "/usr/bin/zsh" ]; then
  echo "running chsh..you'll have to relogin :/"
  sudo chsh -s `which zsh` matt
fi

if [ ! -f ~/.zshenv ]; then
  echo "creating .zshenv with machine '$1'"
  echo "export MACHINE=\"$1\"" > ~/.zshenv
  . ~/.zshenv
fi


# ---
# dotfiles
# ---
if [ ! -d ~/conf ]; then
  echo "dotfiles!"
  mkdir -p ~/conf
  cd ~/conf
  git clone https://github.com/yosemitebandit/dotdotdot.git
  cd ~/conf/dotdotdot
  git submodule init
  git submodule update
  git clone https://github.com/robbyrussell/oh-my-zsh.git
  ln -s ~/conf/dotdotdot/zshrc ~/.zshrc
  ln -s ~/conf/dotdotdot/yosemitebandit.zsh-theme ~/conf/oh-my-zsh/themes
fi

if [ ! -f ~/.gitconfig ]; then
  echo ".gitconfig !"
  cd ~/conf/dotdotdot
  python build_gitconfig.py
  ln -s ~/conf/dotdotdot/gitconfig ~/.gitconfig
fi


# ---
# make a swap file before we start compiling, in case we're in a VM
# ---
sudo ~/conf/dotdotdot/scripts/add-swap.sh


# ---
# vi
# ---
if [ ! -f ~/.vimrc ]; then
  echo ".vimrc !"
  ln -s ~/conf/dotdotdot/vim ~/.vim
  ln -s ~/conf/dotdotdot/vimrc ~/.vimrc
  vim +PluginInstall +qall
  cd ~/conf/dotdotdot/vim/bundle/YouCompleteMe
  ./install.sh --clang-completer
  ln -s ~/conf/dotdotdot/ycm_extra_conf.py ~/.ycm_extra_conf.py
  sudo pip install pylint
  ln -s ~/conf/dotdotdot/pylintrc ~/.pylintrc
fi


# ---
# python
# ---
if [ ! -d ~/conf/venvs/sci ]; then
  echo "virtualenv!"
  mkdir -p ~/conf/venvs/sci
  virtualenv ~/conf/venvs/sci
  . ~/conf/venvs/sci/bin/activate
  pip install numpy
  pip install scipy
  pip install distribute --upgrade
  pip install matplotlib
  deactivate
fi


# ---
# go
# ---
if [ ! -e /usr/local/go ]; then
  echo "go!"
  wget https://storage.googleapis.com/golang/go1.3.2.src.tar.gz -P ~
  tar -xvf ~/go1.3.2.src.tar.gz -C ~
  sudo mv ~/go /usr/local
  cd /usr/local/go/src
  ./all.bash
  mkdir -p ~/gocode
  rm ~/go1.3.2.src.tar.gz
fi


# ---
# clojure
# ---
if [ ! -f /usr/local/bin/lein ]; then
  echo "clojure!"
  wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -P ~
  chmod +x ~/lein
  sudo mv ~/lein /usr/local/bin
  lein -h
fi


# ---
# remove the swap file
# ---
sudo ~/conf/dotdotdot/scripts/delete-swap.sh


echo "done!"
