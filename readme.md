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

# login as matt
# add your public key for password-less ssh
$ mkdir .ssh
$ touch .ssh/authorized_keys

# run the ubuntu setup script
$ wget https://raw.githubusercontent.com/yosemitebandit/dotdotdot/master/scripts/get-ubuntu-packages.sh
$ chmod +x get-ubuntu-packages.sh
$ ./get-ubuntu-packages.sh
```


### setup common languages
to bootstrap a brand new `trusty` instance with languages I like,
execute the script from `scripts/bootstrap-languages.sh`

    $ wget https://raw.githubusercontent.com/yosemitebandit/dotdotdot/master/scripts/bootstrap-languages.sh
    $ chmod +x bootstrap-languages.sh
    $ ./bootstrap-languages.sh


### dotfile bootstrapping
to bootstrap a brand new `trusty` instance with my dotfiles,
execute the script from `scripts/bootstrap-dotfiles.sh`

    $ wget https://raw.githubusercontent.com/yosemitebandit/dotdotdot/master/scripts/bootstrap-dotfiles.sh
    $ chmod +x bootstrap-dotfiles.sh
    $ ./bootstrap-dotfiles.sh <email> <machine> <bits>


### machine differences
There are some slight differences between zsh setups on different machines,
namely the git email and the zsh path.
We capture those differences in a `zshenv` file generated with the `bootstrap-dotfiles.sh` script.
These files are quite simple, here's an example:

```
export MACHINE="work_laptop"
export BITS="64"
```


### mac bootstrapping

Still busted on mac:
`gitk`,
that nice `copy` alias,
`ycm`,
`syntastic`.

Otherwise:

```
brew install the_silver_searcher
brew install icdiff
brew install ctags
brew install node
npm install -g npm@latest
```


### gui stuff

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
* modify keyboard shortcuts for tab changes
* set unlimited scrollback
