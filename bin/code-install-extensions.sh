#!/bin/bash

extensionsList=$HOME/.config/Code/User/extensions-list.txt
set -ev

# Install new / Update installed
for ext in $(cat ~/.config/Code/User/extensions-list.txt); do code --install-extension ${ext} || echo "\tskipped... 😢"; done


# Delete if not found in extensions list
currentlyInstalled=/tmp/code-extensions-list.txt
code --list-extensions > ${currentlyInstalled}
needToDelete=$(comm -23 ${currentlyInstalled} ${extensionsList})

for ext in $needToDelete; do
    read -p "Delete '$ext' (y/n) extension? " choice
    case "$choice" in
    y|Y ) code --uninstall-extension ${ext};;
    n|N ) echo "skipped";;
    * ) ;;
    esac
done;
