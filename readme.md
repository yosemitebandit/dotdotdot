the way in which I setup my dev environment nowadays

works best on 64bit trusty tahr


### first-time setup bits

```shell
# create a new user
$ sudo adduser matt
$ sudo usermod -a -G sudo matt

# set the hostname
$ sudo vi /etc/hostname
# make the second line map to 127.0.0.1 <hostname>
$ sudo vi /etc/hosts
# (reboot for it to take effect)

# add your public key for password-less ssh
$ mkdir .ssh
$ touch .ssh/authorized_keys

# run the ubuntu setup script
$ wget https://raw.githubusercontent.com/yosemitebandit/dotdotdot/master/scripts/get-ubuntu-packages.sh
$ chmod +x get-ubuntu-packages.sh
$ ./get-ubuntu-packages.sh
```


### dotfile bootstrapping
to bootstrap a brand new trusty instance,
execute the bootstrap script from `scripts/bootstrap-dotfiles.sh`

    $ wget https://raw.githubusercontent.com/yosemitebandit/dotdotdot/master/scripts/bootstrap-dotfiles.sh
    $ chmod +x bootstrap.sh
    $ ./bootstrap.sh <email> <machine> <bits>


### machine differences
there are some slight differences between zsh setups on different machines.
namely the git email, zsh path and the use of g4d.
the `zshenv` file describe above mediates these differences.


### ubuntu workspaces
* install compiz:

```shell
$ sudo apt-get install compizconfig-settings-manager
```

* in compiz, edit general options > desktop size
  * horizontal 3, vertical 1
* in keyboard, edit shortcuts
  * move to workspace left: ctrl+alt+h
  * move to workspace right: ctrl+alt+l
* appearance > behavior > auto-hide launcher


### terminal
* modify keyboard shortcuts for tab changes
* set unlimited scrollback


### other nice apps
* kazam screencaster
* vlc
