#!/bin/bash
# reworked version of the https://bitbucket.org/durdn/cfg/raw/master/.bin/install.sh
set -ev

repo="git@github.com:rodmax/dotfiles.git"

function dotfiles {
    /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

git clone --bare ${repo} $HOME/.dotfiles
mkdir -p .dotfiles-backup

set +e  # we need to check "checkout" error code so disable -e flag
dotfiles checkout
if [ $? = 0 ]; then
    echo "Checked out dotfiles.";
else
    echo "Backing up pre-existing dot files.";
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;
dotfiles checkout master
dotfiles config status.showUntrackedFiles no
