#!/bin/bash

set -ev
for ext in $(cat ~/scripts/code-extensions.txt); do code --install-extension ${ext}; done

