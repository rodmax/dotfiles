#!/bin/bash
set -e  # exit on any command error
set -x

run_0() {
    # From here https://itsfoss.com/vim-8-release-install/
    sudo add-apt-repository ppa:jonathonf/vim
    sudo apt update

    sudo apt install terminator tmux git zsh tree gitg gawk vim libappindicator-dev flameshot htop xclip

    mkdir -p ~/bin
    cd ~/bin
    wget git.io/trans
    chmod +x ./trans

    run_0_2
    run_0_3

    # Needed to correct work vscode/webpack processes
    # https://github.com/gatsbyjs/gatsby/issues/11406#issuecomment-458769756
    echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

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
    
    # Use flameshot as default tool for screenshot global hot keys
    # https://askubuntu.com/a/1116076
    echo "Setup flameshot as system screenthot app"
    gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot '[]'
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
        "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ \
        name 'flameshot'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ \
        command 'flameshot gui'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ \
        binding 'Print'
}

run_0_3() {
    defaultHomeFolder=/home/max
    if [ "$HOME" != "$defaultHomeFolder" ]; then
        # It is needed to some resources from vscode config hardcoded to /home/max/... folder
        echo "Creating symbolic link $defaultHomeFolder to folder $HOME..."
        sudo ln -s "/home/$(whoami)"  /home/max
    fi
}

run_1() {
    echo "Cloning dotfiles repo...[FIXME] bellow screept may not working"
    export PATH="$HOME/bin:$PATH"

    repo="git@github.com:rodmax/dotfiles.git"


    git clone --bare ${repo} $HOME/.dotfiles
    mkdir -p .dotfiles-backup
    dof config user.email rodionov.m.m@gmail.com
    
    set +e
    dof checkout
    err=$?
    set -e
    if [ $err = 0 ]; then
        echo "Successfully checked out dotfiles.";
    else
        echo "Backing up pre-existing dot files.";
        dof checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
    fi;

    # to fix this issue https://stackoverflow.com/a/20338558
    dof config  remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'

    dof checkout master
    dof config status.showUntrackedFiles no

    dof fetch
    dof branch --set-upstream-to=origin/master master
}

run_2() {
    echo "Installing ohmyzsh and friends..."
    rm -rf .oh-my-zsh
    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    echo "Restart terminal and run run_2_1 command to finish oh-my-zsh installing"
}

run_2_1() {
    dof checkout ~/.zshrc ~/.oh-my-zsh

    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
}


run_3() {
    echo "Installing nvm/npm/node..."
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    nvm install 14
    nvm alias defaul 14
    # At the moment i use bellow global npm packages
    npm i -g vmd @angular/cli npm-check-updates ndb commitizen
}


dof() {
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}


command=$1
shift

set -x  # print executing commands
$command
