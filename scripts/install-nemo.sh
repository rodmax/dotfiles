#!/bin/bash
set -ex
sudo apt update
sudo apt install nemo
nemo --version

# Make `xdg-open` open up directories in nemo instead of nautilus
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
gsettings set org.nemo.desktop show-desktop-icons true
gsettings set org.gnome.desktop.background show-desktop-icons false
sudo apt remove nautilus