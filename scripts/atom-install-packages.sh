#!/bin/bash

set -ev
apm install --packages-file $HOME/scripts/atom-packages.txt
# My fork with some patches
apm install rodmax/language-html
