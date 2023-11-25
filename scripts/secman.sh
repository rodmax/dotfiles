#!/bin/bash
# SecMan - secret manager
set -euo pipefail
secret_dir=~/Documents/me/.secrets
# red_cl='\033[0;31m'
green_cl='\033[0;32m'
no_cl='\033[0m'


cmd=$1
secret_name=${2:-}
secret_suffix=.txt.gpg
secret_file=${secret_dir}/${secret_name}${secret_suffix}

clip_secret () {
    secret_value=$(gpg --decrypt "${secret_file}" | tr -d '\n')
    echo -e "${green_cl}\"${secret_name}\" secret copied to clipboard${no_cl}"
    printf "%s" "$secret_value" | xclip -sel clip
}

create_secret () {
    echo "Enter \"${secret_name}\" value:"
    read -r secret_value
    tmp_file=/tmp/sec
    echo "${secret_value}" > "${tmp_file}"
    gpg -c --output="${secret_file}" ${tmp_file}
    rm ${tmp_file}
}

list_secret () {
    ls -1 ${secret_dir} | xargs basename --suffix=${secret_suffix}
}

"${cmd}_secret"