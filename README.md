# Repository to backup my PC configuration files
The idea is borrowed [here](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)

## Init this repository
```bash
git init --bare $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc

# To prevent eror on dotfiles pull we need to set name and email
dotfiles config user.name "max.rodionov"
dotfiles config user.email "max.rodionov@synesis.ru"
```

## Install `dotfiles` on new machine
```bash
wget -qO- https://raw.githubusercontent.com/rodmax/dotfiles/master/scripts/dotfiles-install.sh | bash
```

## How To
### Setup new system(linux mint 18)
- Install packages
```bash
sudo apt-get install terminator gnome-do git zsh tree
```
- Set terminator as default terminal in **"Prefered application"** to open using `ctrl-alt-t` 
- Install vim (8.0) from [here](https://itsfoss.com/vim-8-release-install/)
- install  `nvm` and `node`
TODO
- install some monospace pretty font
- install atom
