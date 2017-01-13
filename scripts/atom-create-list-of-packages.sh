#!/bin/bash

set -ev
apm list --installed --bare | grep --invert-match language-html > $HOME/scripts/atom-packages.txt
