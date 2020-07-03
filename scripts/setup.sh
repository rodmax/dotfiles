#!/bin/bash
set -e  # exit on any command error

run_0() {
    # From here https://itsfoss.com/vim-8-release-install/
    sudo add-apt-repository ppa:jonathonf/vim
    sudo apt update

    sudo apt install terminator tmux git zsh tree gitg gawk vim libappindicator-dev flameshot
    sudo apt install terminator tmux git zsh tree shutter gitg gawk vim shutter libappindicator-dev flameshot
    sudo apt install htop terminator tmux git zsh tree gitg gawk vim shutter libappindicator-dev flameshot

    mkdir -p ~/bin
    cd ~/bin
    wget git.io/trans
    chmod +x ./trans

    run_0_2
    run_0_3

    # ssh-keygen -t rsa -b 4096 -C "rodionov.m.m@gmail.com"
    echo -e "Please setup ssh key on github and run 'run_1' command"
}

run_0_2() {
    # Setup layout change keyboard shortcut
    # https://askubuntu.com/a/1029605
    gsettings set org.gnome.desktop.input-sources xkb-options "['grp:alt_shift_toggle']"

    # Unset ubuntu defaults
    gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['']"
    gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward  "['']"
    gsettings set org.freedesktop.ibus.general.hotkey triggers "['']"
}

run_0_3() {
    defaultHomeFolder=/home/max
    if [ "$HOME" != "$defaultHomeFolder" ]; then
        # It is needed to some resources from vscode config hardcoded to /home/max/... folder
        echo "Creating symbolic link $defaultHomeFolder to folder $HOME..."
        sudo ln -s /home/max "/home/$(whoami)"
    fi
}

run_1() {
    echo "Cloning dotfiles repo...[FIXME] bellow screept may not working"
    export PATH="$HOME/bin:$PATH"

    repo="git@github.com:rodmax/dotfiles.git"


    git clone --bare ${repo} $HOME/.dotfiles
    mkdir -p .dotfiles-backup
    dof config user.email rodionov.m.m@gmail.com

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
    rm -rf .oh-my-zsh
    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
}

run_2_1() {
    dof checkout ~/.zshrc ~/.oh-my-zsh

    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
}


run_3() {
    echo "Installing nvm/npm/node..."
    # wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    nvm install 14
    nvm alias defaul 14
    # At the moment i use bellow global npm packages
    npm i -g vmd @angular/cli npm-check-updates ndb vmd
}

run_4() {
    echo "Setup flameshot as system screenthot app"
    # https://askubuntu.com/a/1116076
    gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot '[]'
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
        "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ \
        name 'flameshot'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ \
        command '/usr/bin/flameshot gui'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ \
        binding 'Print'
}

dof() {
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}




command=$1
shift

set -x  # print executing commands
case $command in
    run_0)
        run_0
        ;;
    run_0_1)
        run_0_1 # NOTE: this step already included in run_0 but we can do it separatally
        ;;
    run_0_2)
        run_0_2 # NOTE: this step already included in run_0 but we can do it separatally
        ;;
    run_1)
        run_1
        ;;
    run_2)
        run_2
        ;;
    run_2_1)
        run_2_1
        ;;
    run_3)
        run_3
        ;;
    run_4)
        run_4
        ;;
    *)
        echo "Unknown command \"$command\" passed"
        exit 1
esac
