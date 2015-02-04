#!/usr/bin/env bash
#
# setting up ubuntu
# github.com/yosemitebandit/dotdotdot
#
# usage:
#   ./get-ubuntu-packages.sh

# ---
# apt - upgrades, git, vim, python, etc
# ---
echo "apt!"

sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get -y install git-core git-gui gitk zsh vim-gtk exuberant-ctags \
                        mercurial cmake python-dev software-properties-common \
                        python-software-properties python-pip python-dev \
                        python-virtualenv build-essential gfortran \
                        libopenblas-dev liblapack-dev libxft-dev libfreetype6-dev \
                        libpng-dev openjdk-7-jdk tmux silversearcher-ag tree \
                        xdg-utils sqlite3

# add-apt-repo may not be available until after first upgrade
sudo add-apt-repository ppa:nmi/vim-snapshots -y
sudo apt-get update -y
sudo apt-get upgrade -y

echo "done!"
