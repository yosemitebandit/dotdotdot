the way in which I setup my dev environment nowadays

last tested on ubuntu 12.04


### machine differences
there are some slight differences between zsh setups on different machines.
namely the git email, zsh path and the use of g4d.
so first create a ~/.zshenv file with one line:

    export MACHINE="home"

or another option from the zshrc.
this'll workout the differences when the zsh config is loaded..
erm, and this setup only partially works on a mac :/


### git

    $ sudo apt-get install git-core git-gui gitk
    $ ssh-keygen -t rsa -C "matt@yup.com"
    $ cd dotdotdot/git
    $ python build_gitconfig.py
    $ ln -s /full/path/to/dotdotdot/git/_gitconfig /home/path/.gitconfig

add the public key to github


### zsh
zsh settings and themes

    $ git clone git://github.com/robbyrussell/oh-my-zsh.git
    $ ln -s /full/path/to/dotdotdot/zshrc /home/path/.zshrc
    $ ln -s /full/path/to/dotdotdot/yosemitebandit.zsh-theme /path/to/oh-my-zsh/themes/yosemitebandit.zsh-theme
    $ sudo apt-get install zsh
    $ chsh -s /bin/zsh


### vi
gvim, a vimrc, various plugins and colorschemes

    $ sudo apt-get install vim-gtk exuberant-ctags
    $ ln -s /full/path/to/dotdotdot/vim /home/path/.vim
    $ ln -s /full/path/to/dotdotdot/vim/vimrc /home/path/.vimrc
    $ cd /full/path/to/dotdotdot
    $ git submodule update --init --recursive
    $ mkdir /home/path/.vim/backup
    $ cd dotdotdot/vim/bundle/YouCompleteMe
    $ ./install.sh --clang-completer

also symlink the YCM extra conf file to ~

if you need to upgrade vim for YCM:

    $ sudo add-apt-repository ppa:nmi/vim-snapshots
    $ sudo apt-get update && sudo apt-get upgrade


### python
install pylint and then symlink this repo's pylintrc to ~

    $ sudo pip install pylint

and then if you can install numpy, scipy and matplotlib, you're on the right track..

    $ sudo apt-get install python-pip python-dev python-virtualenv build-essential
    $ sudo apt-get install gfortran libopenblas-dev liblapack-dev libfreetype6-dev libpng-dev
    $ mkdir /path/to/venvs
    $ virtualenv path/to/venvs/sci
    $ source path/to/venvs/sci/bin/activate
    (sci) $ pip install numpy
    (sci) $ pip install scipy
    (sci) $ pip install distribute --upgrade
    (sci) $ pip install matplotlib


### go
setup go in /usr/local as per the docs: golang.org/doc/install, and then:

    $ mkdir ~/gocode


### arduino
need jdk for the ui; and I think this is better than the version that's in apt

    $ sudo apt-get install openjdk-7-jre
    $ mkdir archive && cd archive
    $ wget http://arduino.googlecode.com/files/arduino-1.0.5-linux32.tgz
    $ tar-xvf arduino-1.0.5-linux32.tgz
    $ mkdir /path/to/archive/arduino-sketchbook

and then edit `~/.arduino/preferences.txt` to change the sketchbook path


### workspaces
* install compiz

    $ sudo apt-get install compizconfig-settings-manager

* in compiz, edit general options > desktop size
  * horizontal 3, vertical 1
* in keyboard, edit shortcuts
  * move to workspace left: ctrl+alt+h
  * move to workspace right: ctrl+alt+l
* appearance > behavior > auto-hide launcher


### terminal
* modify keyboard shortcuts
* change font
* unlimited scrollback


### other nice apps from the ubuntu sw center, ppas and elsewhere
* synapse
* source code pro - get the TTF from font squirrel
* kazam screencaster
* vlc
* ack-grep (and rename it ack)
* freecad

    $ sudo apt-get install ack-grep
    $ sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
    $ sudo add-apt-repository ppa:freecad-maintainers/freecad-stable
    $ sudo apt-get update && sudo apt-get install freecad
