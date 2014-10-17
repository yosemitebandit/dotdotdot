# bootstrapping a new ubuntu machine with my dotfiles
# github.com/yosemitebandit/dotdotdot
#
# $ bootstrap.sh <machine> <email>


# ---
# apt - uprades, vim, python, ack
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
# basic stuff, users, sec, etc
# ---
echo "user stuff!"
if [! id -u matt >/dev/null 2>&1]; then
  sudo adduser matt
  sudo usermod -a -G sudo matt
fi

if [ ! -e ~/.ssh/id_rsa.pub ]; then
  echo "creating ssh keys with email '$2'"
  ssh-keygen -t rsa -C "$2" -N "" -f ~/.ssh/id_rsa
  echo "add this public key to github:"
  cat ~/.ssh/id_rsa.pub
fi



# ---
# zsh and git and dotfiles
# ---
if [ ! $SHELL == "/usr/bin/zsh" ]; then
  echo "running chsh..you'll have to relogin :/"
  sudo chsh -s `which zsh` matt
fi

if [ ! -f ~/.zshenv ]; then
  echo "creating .zshenv with machine '$1'"
  echo "export MACHINE=\"$1\"" > ~/.zshenv
fi

if [ ! -d ~/conf ]; then
  echo "~/conf !"
  mkdir -p ~/conf
  cd ~/conf
  git clone https://github.com/yosemitebandit/dotdotdot.git
  git clone https://github.com/robbyrussell/oh-my-zsh.git
  ln -s ~/conf/dotdotdot/zshrc ~/.zshrc
  ln -s ~/conf/dotdotdot/yosemitebandit.zsh-theme ~/conf/oh-my-zsh/themes
fi

if [ ! -f ~/.gitconfig ]; then
  echo ".gitconfig !"
  python ~/conf/dotdotdot/build_gitconfig.py
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
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim vim +PluginInstall +qall
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
fi


# ---
# remove the swap file
# ---
sudo ~/conf/dotdotdot/scripts/delete-swap.sh


echo "done!"
