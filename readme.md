the way in which I setup my dev environment nowadays

works best on 64bit trusty tahr


### experimental bootstrapping
to bootstrap a brand new trusty instance,
fetch the bootstrap script from `scripts/bootstrap.sh`
and execute it as user 'matt':

    $ sudo adduser matt
    $ sudo usermod -a -G sudo matt
      # relogin as matt..
    $ wget https://raw.githubusercontent.com/yosemitebandit/dotdotdot/master/scripts/bootstrap.sh
    $ chmod +x bootstrap.sh
    $ ./bootstrap.sh <machine> <email>



### experimental dotfile-buildin
* could run a build script to generate my..
  * gitconfig, tmux.conf, vimrc, zshrc, pypirc
* config files for different machines and oses could be used by the build script
* a separate script or playbook could setup ubuntu or my mac
* hopefully the build script just injects into a common template
  * would suck to have template dotfiles that aren't valid vimscript or whatever

* vimrc:
  * will need to enable specific vundle plugins in a specific line in the vimrc :/
* zshrc:
  * get rid of those nasty zshenv checks
* gitconfig
  * would just take an email addr..

* maybe we just focus on trusty and precise64
  * macs are just for logging into vboxes and precise32 is rare



### machine differences
there are some slight differences between zsh setups on different machines.
namely the git email, zsh path and the use of g4d.
so first create a ~/.zshenv file with two lines:

    export MACHINE="home"
    export BITS=64

or another option from the zshrc.
this'll workout the differences when the zsh config is loaded..
erm, and this setup only partially works on a mac :/
and on 32bit precise, YCM and syntastic don't work out of the box



### arduino setup
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
* change font to source code pro - get the TTF from font squirrel
* set unlimited scrollback


### other nice apps from the ubuntu sw center, ppas and elsewhere
* kazam screencaster
* vlc
