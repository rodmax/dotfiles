#!/bin/bash

set -ev
for ext in $(cat ~/.config/Code/User/extensions-list.txt); do code --install-extension ${ext}; done

