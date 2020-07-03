#!/bin/bash
set -e  # exit on any command error

run_0() {
    # From here https://itsfoss.com/vim-8-release-install/
    sudo add-apt-repository ppa:jonathonf/vim
    sudo apt update

    sudo apt install terminator tmux git zsh tree gitg gawk vim libappindicator-dev flameshot

    mkdir -p ~/bin
    cd ~/bin
    wget git.io/trans
    chmod +x ./trans

    run_0_1

    # ssh-keygen -t rsa -b 4096 -C "rodionov.m.m@gmail.com"
    echo -e "Please setup ssh key on github and run 'run_1' command"
}

run_0_1() {
    # Receipt from https://itsfoss.com/shutter-edit-button-disabled/
    # Bellow command should be run after libappindicator-dev installed (see apt install in run_0 )
    sudo cpan -i Gtk2::AppIndicator

    mkdir ~/libgoo-canvas-perl && cd ~/libgoo-canvas-perl
    wget https://launchpad.net/ubuntu/+archive/primary/+files/libgoocanvas-common_1.0.0-1_all.deb
    wget https://launchpad.net/ubuntu/+archive/primary/+files/libgoocanvas3_1.0.0-1_amd64.deb
    wget https://launchpad.net/ubuntu/+archive/primary/+files/libgoo-canvas-perl_0.06-2ubuntu3_amd64.deb
    sudo dpkg -i *.deb
    sudo apt install -f
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
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
    nvm install 12
    nvm alias defaul 12
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
