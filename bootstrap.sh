# bootstrapping a new ubuntu machine with my dotfiles
# github.com/yosemitebandit/dotdotdot
#
# $ bootstrap.sh <machine> <email>

# ---
# apt - uprades, vim, python, ack
# ---
sudo add-apt-repository ppa:nmi/vim-snapshots -y
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get -y install git-core git-gui gitk zsh vim-gtk exuberant-ctags \
                        mercurial cmake python-dev software-properties-common \
                        python-software-properties python-pip python-dev \
                        python-virtualenv build-essential fortran libopenblas-dev \
                        liblapack-dev libfreetype6-dev libpng-dev ack-grep
sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

# ---
# custom
# ---
echo "running chsh..you'll have to relogin :/"
sudo chsh -s `which zsh` matt

if [ ! -f ~/.zshenv ]; then
  echo "creating .zshenv with machine '$1'"
  echo "export MACHINE=\"$1\"" > ~/.zshenv
fi

if [ ! -e ~/.ssh/id_rsa.pub ]; then
  echo "creating ssh keys with email '$2'"
  ssh-keygen -t rsa -C "$2" -N "" -f ~/.ssh/id_rsa
  echo "add this public key to github:"
  cat ~/.ssh/id_rsa.pub
fi

if [ ! -d ~/conf ]; then
  mkdir -p ~/conf
  cd ~/conf
  git clone https://github.com/yosemitebandit/dotdotdot.git
  git clone git://github.com/robbyrussell/oh-my-zsh.git
  ln -s ~/conf/dotdotdot/zshrc ~/.zshrc
  ln -s ~/conf/dotdotdot/yosemitebandit.zsh-theme ~/conf/oh-my-zsh/themes
fi

if [ ! -f ~/.gitconfig ]; then
  cd ~/conf/dotdotdot
  python build_gitconfig.py
  ln -s ~/conf/dotdotdot/gitconfig ~/.gitconfig
fi

if [ ! -f ~/.vimrc ]; then
  ln -s ~/conf/dotdotdot/vim ~/.vim
  ln -s ~/conf/dotdotdot/vimrc ~/.vimrc
  vim +PluginInstall +qall
  cd ~/conf/dotdotdot/vim/bundle/YouCompleteMe
  ./install.sh --clang-completer
  ln -s ~/conf/dotdotdot/ycm_extra_conf.py ~/.ycm_extra_conf.py
  sudo pip install pylint
  ln -s ~/conf/dotdotdot/pylintrc ~/.pylintrc

fi

echo "done"
