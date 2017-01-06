# Path to your oh-my-zsh installation.
export ZSH=/home/max/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git, npm, docker)


source $ZSH/oh-my-zsh.sh

# User configuration

export EDITOR='vim'

export NVM_DIR="/home/max/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
alias dotfiles='/usr/bin/git --git-dir=/home/max/.dotfiles/ --work-tree=/home/max'
