# Repository to backup my PC configuration files
The idea is borrowed [here](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)

## Setup new system(linux mint 18)
- Install packages

```bash
# From here https://itsfoss.com/vim-8-release-install/
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update

sudo apt install terminator tmux git zsh tree shutter shellcheck gitg gawk vim

mkdir ~/.nvm
mkdir -p ~/bin
cd ~/bin
wget git.io/trans
chmod +x ./trans

# [translate-shell utility](https://github.com/soimort/translate-shell)
cd ~/bin
wget git.io/trans
chmod +x ./trans

ssh-keygen -t rsa -b 4096 -C "rodionov.m.m@gmail.com"
```

## Put SSH key to github accaunt

```bash
# Copying...
cat ~/.ssh/id_rsa.pub
...
# And paste to your profile on github.com
```

## Install this `dotfiles` repo

```bash
export PATH="$HOME/bin:$PATH"
wget -qO- https://raw.githubusercontent.com/rodmax/dotfiles/master/scripts/dotfiles-install.sh | bash
alias dof='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dof lg # check it
dof branch --set-upstream-to=origin/master master
```

## Install `ohmyzsh`
[ohmyzsh](http://ohmyz.sh/)

## Install node and nvm
Install  `nvm` and `node` [link](https://github.com/creationix/nvm)

```bash
nvm install 12
nvm alias defaul 12
# At the moment i used need global npm packages
npm i -g vmd @angular/cli npm-check-updates
```
