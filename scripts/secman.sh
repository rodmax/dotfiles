#!/bin/bash
# SecMan - secret manager
set -euo pipefail
secret_dir=~/Documents/me/.secrets
green_cl='\033[0;32m'
red_cl='\033[0;31m'
no_cl='\033[0m'


cmd=$1
secret_name=${2:-}
secret_suffix=.txt.gpg
secret_file=${secret_dir}/${secret_name}${secret_suffix}

clip_secret () {
    ls -l "${secret_file}" > /dev/null # make sure file exists

    if secret_value=$(gpg --decrypt "${secret_file}" | tr -d '\n'); then
        echo -e "${green_cl}\"${secret_name}\" secret copied to clipboard${no_cl}"
        printf "%s" "$secret_value" | xclip -sel clip
        return 0
    fi

    echo -e "${red_cl}Failed to decrypt secret: \"$secret_name\".\nMake sure CAPS_LOCK is off, input language, and try again.${no_cl}"
    return 1
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
    # NOTE: -print0 and xargs -0 are used to handle filenames with spaces
    find "${secret_dir}" -type f -name "*${secret_suffix}" -print0 | xargs -0 basename --suffix="${secret_suffix}" | sort
}

"${cmd}_secret"
