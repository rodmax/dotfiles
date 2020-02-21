#!/bin/bash

extensionsList=$HOME/.config/Code/User/extensions-list.txt
set -e

# Install new / Update installed
grep -v '^ *#' <  "$extensionsList" | while IFS= read -r ext
do
    printf "[%s]\n" "$ext"
    code --install-extension "${ext}" || printf "skipped 👀 \n\n"
    printf "\n"
done



# Delete if not found in extensions list
currentlyInstalled=/tmp/code-extensions-list.txt
code --list-extensions > ${currentlyInstalled}
needToDelete=$(comm -23 "${currentlyInstalled}" "${extensionsList}")

for ext in $needToDelete; do
    read -rp "Delete '$ext' (y/n) extension? " choice
    case "$choice" in
    y|Y ) code --uninstall-extension "${ext}";;
    n|N ) echo "skipped";;
    * ) ;;
    esac
done;
