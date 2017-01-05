# Repository to backup my PC configuration files

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
## How To
### Install VIM
