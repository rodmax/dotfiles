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
```
- Set terminator as default terminal in **"Prefered application"** to open using `ctrl-alt-t` 
- Install vim (8.0) from [here](https://itsfoss.com/vim-8-release-install/)
- install  `nvm` and `node`
TODO
- install some monospace pretty font
- install atom
