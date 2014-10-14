# bootstraps my dotfiles
# github.com/yosemitebandit/dotdotdot

# ---
# apt
# ---
sudo apt-get update -y
sudo apt-get upgrade -y

# basics
sudo apt-get -y install git-core git-gui gitk
sudo apt-get -y install zsh

# vim
sudo apt-get -y install vim-gtk exuberant-ctags mercurial cmake python-dev
sudo apt-get -y install software-properties-common python-software-properties
sudo add-apt-repository ppa:nmi/vim-snapshots
sudo apt-get update -y && sudo apt-get upgrade -y

# python
sudo apt-get install -y python-pip python-dev python-virtualenv build-essential
sudo apt-get install -y fortran libopenblas-dev liblapack-dev libfreetype6-dev libpng-dev

# ack-grep (and rename to ack)
sudo apt-get install ack-grep -y
sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

# ---
# custom
# ---
echo "creating .zshenv with machine '$1'"
echo "export MACHINE=\"$1\"" > ~/.zshenv

echo "creating ssh keys with email '$2'"
ssh-keygen -t rsa -C "$2"
echo "add this public key to github:"
cat ~/.ssh/id_rsa.pub

mkdir ~/conf
cd ~/conf
git clone https://github.com/yosemitebandit/dotdotdot.git
python build_gitconfig.py
ln -s ~/dotdotdot/gitconfig ~/.gitconfig
