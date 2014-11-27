#!/usr/bin/env bash
# bootstrapping a new machine with my dotfiles
# github.com/yosemitebandit/dotdotdot
#
# $ bootstrap-dotfiles.sh <email> <machine> <bits>

# ---
# go no further if we're not running this with user 'matt'
# ---
if [ ! `whoami` == matt ]; then
  echo "sorry, you need to make a 'matt' user first"
  echo "probably via 'sudo adduser matt && sudo usermod -a -G sudo matt'"
  exit 1
fi


# ---
# ssh keys
# ---
if [ ! -e ~/.ssh/id_rsa.pub ]; then
  echo "ssh keys!"
  echo "creating ssh keys with email '$1'"
  ssh-keygen -t rsa -C "$1" -N "" -f ~/.ssh/id_rsa
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
  echo "creating .zshenv with '$3' bit machine '$2'"
  echo "export MACHINE=\"$2\"" > ~/.zshenv
  echo "export BITS=\"$3\"" >> ~/.zshenv
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
  git submodule init && git submodule update
  cd ~/conf
  git clone https://github.com/robbyrussell/oh-my-zsh.git
  ln -s ~/conf/dotdotdot/zshrc ~/.zshrc
  ln -s ~/conf/dotdotdot/yosemitebandit.zsh-theme ~/conf/oh-my-zsh/themes/yosemitebandit.zsh-theme
  ln -s ~/conf/dotdotdot/tmux.conf ~/.tmux.conf
fi

if [ ! -f ~/.gitconfig ]; then
  echo ".gitconfig !"
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
  sudo pip install pylint
  ln -s ~/conf/dotdotdot/pylintrc ~/.pylintrc

  vim +PluginInstall +qall

  if [ ! $MACHINE == "mac" ]; then
    if [ ! $BITS == 64 ]; then
      cd ~/conf/dotdotdot/vim/bundle/YouCompleteMe
      ./install.sh --clang-completer
      ln -s ~/conf/dotdotdot/ycm_extra_conf.py ~/.ycm_extra_conf.py
    fi
  fi
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
  pip install distribute --upgrade
  pip install matplotlib
  deactivate
  ln -s ~/conf/dotdotdot/pypirc ~/.pypirc
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


echo ""
echo "you should relogin to use zsh"
echo "done!"
