#!/bin/bash
set -e  # exit on any command error


run_0() {
    # From here https://itsfoss.com/vim-8-release-install/
    sudo add-apt-repository ppa:jonathonf/vim
    sudo apt update

    sudo apt install terminator tmux git zsh tree shutter shellcheck gitg gawk vim

    mkdir -p ~/bin
    cd ~/bin
    wget git.io/trans
    chmod +x ./trans

    # ssh-keygen -t rsa -b 4096 -C "rodionov.m.m@gmail.com"
    echo -e "Please setup ssh key on github and run 'run_1' command"
}

run_1() {
    echo "Cloning dotfiles repo..."
    export PATH="$HOME/bin:$PATH"

    alias dof='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

    repo="git@github.com:rodmax/dotfiles.git"


    git clone --bare ${repo} $HOME/.dotfiles
    mkdir -p .dotfiles-backup

    dof checkout
    if [ $? = 0 ]; then
        echo "Successfully checked out dotfiles.";
    else
        echo "Backing up pre-existing dot files.";
        dof checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
    fi;

    # to fix this issue https://stackoverflow.com/a/20338558
    dof config  remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'

    dof checkout master
    dof config status.showUntrackedFiles no

    dof lg # check it
    dof branch --set-upstream-to=origin/master master
}

run_2() {
    echo "Installing ohmyzsh and friends..."
    $ sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
}

run_3() {
    echo "Installing nvm/npm/node..."
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
    nvm install 12
    nvm alias defaul 12
    # At the moment i use bellow global npm packages
    npm i -g vmd @angular/cli npm-check-updates ndb vmd
}

command=$1
shift

set -x  # print executing commands
case $command in
    run_0)
        run_0
        ;;
    run_1)
        run_1
        ;;
    run_2)
        run_2
        ;;
    run_3)
        run_3
        ;;
    *)
        echo "Unknown command \"$command\" passed"
        exit 1
esac