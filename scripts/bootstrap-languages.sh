#!/usr/bin/env bash
# bootstrapping a new machine with some languages
# github.com/yosemitebandit/dotdotdot
#
# $ bootstrap-languages.sh

# ---
# go no further if we're not running this with user 'matt'
# ---
if [ ! `whoami` == matt ]; then
  echo "sorry, you need to make a 'matt' user first"
  echo "probably via 'sudo adduser matt && sudo usermod -a -G sudo matt'"
  exit 1
fi


# ---
# add a swap file
# ---
sudo ~/conf/dotdotdot/scripts/add-swap.sh


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
  pip install pandas
  pip install scipy
  pip install sklearn
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
# node
# ---
if [ ! hash npm 2>/dev/null ]; then
  echo "node!"
  curl -sL https://deb.nodesource.com/setup | sudo bash -
  sudo apt-get install -y nodejs
  npm install -g npm@latest
  sudo npm install -g jshint
  sudo npm install -g jsxhint
fi


# ---
# remove the swap file
# ---
sudo ~/conf/dotdotdot/scripts/delete-swap.sh


echo ""
echo "done!"
