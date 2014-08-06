the way in which I setup my dev environment nowadays

last tested on ubuntu 12.04


### machine differences
there are some slight differences between zsh setups on different machines.
namely git email setup, zsh path and the use of g4d.
so first create a ~/.zshenv file with one line:

    export MACHINE="home"

or another option from the zshrc.
this'll workout the differences when the zsh config is loaded..


### git

    $ sudo apt-get install git-core git-gui gitk
    $ ln -s /full/path/to/dotdotdot/git/_gitconfig /home/path/.gitconfig
    $ ssh-keygen -t rsa -C "hola@email.com"

add the public key to github, and edit the `.gitconfig` email addr as appropriate


### zsh

    $ git clone git://github.com/robbyrussell/oh-my-zsh.git
    $ ln -s /full/path/to/dotdotdot/zshrc /home/path/.zshrc
    $ ln -s /full/path/to/dotdotdot/yosemitebandit.zsh-theme /path/to/oh-my-zsh/themes/yosemitebandit.zsh-theme
    $ sudo apt-get install zsh
    $ chsh -s /bin/zsh
    $ cd dotdotdot/git
    $ python build_gitconfig.py

and, in `.zshrc`, edit the path to oh-my-zsh as appropriate


### vi
gvim, a vimrc and various plugins

    $ sudo apt-get install vim-gtk exuberant-ctags
    $ ln -s /full/path/to/dotdotdot/vim /home/path/.vim
    $ ln -s /full/path/to/dotdotdot/vim/vimrc /home/path/.vimrc
    $ cd /full/path/to/dotdotdot
    $ git submodule init
    $ git submodule update
    $ mkdir /home/path/.vim/backup
    $ cd dotdotdot/vim/bundle/YouCompleteMe
    $ git submodule update --init --recursive
    $ ./install.sh --clang-completer

this'll load several plugins and colorschemes


### python
install pylint and then symlink the pylintrc file here to ~

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

also symlink the YCM extra conf file to ~


### arduino
need jdk for the ui; and I think this is better than the version that's in apt

    $ sudo apt-get install openjdk-7-jre
    $ mkdir archive && cd archive
    $ wget http://arduino.googlecode.com/files/arduino-1.0.5-linux32.tgz
    $ tar-xvf arduino-1.0.5-linux32.tgz
    $ mkdir /path/to/archive/arduino-sketchbook

and then edit `~/.arduino/preferences.txt` to change the sketchbook path


### workspaces
* in compiz, edit general options > desktop size
  * horizontal 3, vertical 1
* in keyboard edit shortcuts
  * move to workspace left: ctrl+alt+h
  * move to workspace right: ctrl+alt+l
* appearance > behavior > auto-hide launcher


### terminal
* modify keyboard shortcuts
* change font
* unlimited scrollback


### other nice apps from the ubuntu sw center
* synapse
* source code pro - get the TTF from font squirrel
* kazam screencaster
* vlc
* freecad
* ack-grep
