the way in which I setup my dev environment nowadays

last tested on ubuntu 14.04


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


### machine differences
there are some slight differences between zsh setups on different machines.
namely the git email, zsh path and the use of g4d.
so first create a ~/.zshenv file with one line:

    export MACHINE="home"

or another option from the zshrc.
this'll workout the differences when the zsh config is loaded..
erm, and this setup only partially works on a mac :/


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

also ack-grep and freecad:

    $ sudo apt-get install ack-grep
    $ sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
    $ sudo add-apt-repository ppa:freecad-maintainers/freecad-stable
    $ sudo apt-get update && sudo apt-get install freecad
