# Repository to backup my PC configuration files
The idea is borrowed [here](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)

## Install `dotfiles` on new machine
```bash
wget -qO- https://raw.githubusercontent.com/rodmax/dotfiles/master/scripts/dotfiles-install.sh | bash
```

## How To
### Setup new system(linux mint 18)
- Install packages
```bash
sudo apt install terminator gnome-do git zsh tree python3-dev python3-venv python3-pip g++
sudo pip3 install --upgrade pip

# Optionally install packages for vmware guest(my home installation)
sudo apt install open-vm-tools open-vm-tools-desktop
```
- To make working `gnome-do` you should change settings of the `menu` in top panel via right click:
    - *Main button* tab: change shortcut to Super-R
    - *Applications* tab: Disable search in internet
- Install vim (8.0) from [here](https://itsfoss.com/vim-8-release-install/)
- Setup ssh key and put it to your github profile
```bash
# Generating...
ssh-keygen -t rsa -b 4096 -C "rodionov.m.m@gmail.com"
# Copying...
cat ~/.ssh/id_rsa.pub
...
# And paste to your profile on github.com
```
- Install this dotfiles repo
```bash
wget -qO- https://raw.githubusercontent.com/rodmax/dotfiles/master/scripts/dotfiles-install.sh | bash
alias dotfile='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dofiles lg # check it
```
- Install [ohmyzsh](http://ohmyz.sh/)
- Set terminator as default terminal in **"Preferred application"** to open using `ctrl-alt-t`
- install  `nvm` and `node` (link)[https://github.com/creationix/nvm]
- install atom from [deb package](atom.io)
```
# Install atom plugins using
./scripts/atom-install-packages.sh
```

