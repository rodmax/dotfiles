# Path to your oh-my-zsh installatioexport
export ZSH=$HOME/.oh-my-zsh
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="lambda" #"robbyrussell"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(docker fabric kubectl gulp jira)
source $ZSH/oh-my-zsh.sh


# User configuration
export EDITOR='vim'


alias feh="feh -g 800x600"
alias treel1='tree -L 1 -a'  # i like it instead of 'ls -1a'
alias treel2='tree -L 2 -a'  # i like it instead of 'ls -1a'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
toru() {
    trans en:ru "$*"
}
toen() {
    trans ru:en "$*"
}

# Init virtualenvwrapper envirnment
export WORKON_HOME=~/envs
virtualwrapperScript="/usr/local/bin/virtualenvwrapper.sh"
[ -s "${virtualwrapperScript}" ] && source ${virtualwrapperScript}


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm


[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
