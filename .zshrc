# Path to your oh-my-zsh installatioexport
export ZSH=$HOME/.oh-my-zsh
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="rodmax"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'



# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(docker kubectl jira docker-compose zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh


# User configuration
export EDITOR='vim'


alias tmuxa='tmux a -t'
alias tmuxn='tmux new -s'

alias open-file=xdg-open
alias treel1='tree -L 1 -a'  # i like it instead of 'ls -1a'
alias treel2='tree -L 2 -a'  # i like it instead of 'ls -1a'
alias dof='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias g=git
alias r='npm run'
alias notify-me='notify-send -i face-cool -u low "Job Done!!!" || notify-send -i face-crying -u critical "Job FAILED :("'  # Usage: "npm build && notify-me"
toru() {
    trans en:ru "$*"
}
toen() {
    trans ru:en "$*"
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm


[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin:$HOME/bin

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export JAVA_HOME=$HOME/android-tools/jdk
# TMUX startup

if [ -z "$TMUX" ]; then
    # Create but not attach some default sessions
    for session in "start" "test"; do
        tmux has-session -t ${session} 2>/dev/null || tmux new-session -d -s ${session}
    done
fi
