#!/usr/bin/env bash
# shellcheck disable=SC2059
set -e


thisScript="$0"
rootDir=$(cd "$(dirname "$thisScript")"; pwd)
readarray -t tasksList < <(sed -nE 's/^([a-z,0-9,:,-]+)\s?\(\)\s?\{(.?+)$/\1 \2/p' "$thisScript")

imageName=ubuntu-for-testing
containerName=$imageName-container

info="ℹ️ "
error="❌ "



ubuntu:run() { # Run ubuntu container for automation testing

    local contextDir="${rootDir}/ubuntu-for-testing"


    docker build "$contextDir" -t $imageName
    docker stop $containerName || echo stop skipped
    docker rm $containerName || echo rm skipped

    docker run -it -d \
        --name=$containerName  \
        --mount "type=bind,source=$(pwd),target=/tmp/playbooks,readonly" \
        $imageName
    printf "$info Ubuntu for testing started 🚀."
    printf "\n\tTo jump inside it run: \n\t$thisScript ubuntu:shell\n\n"
}

ubuntu:shell() {
    docker exec -it "$containerName" bash -l
}

os:init() {
    sudo apt update
    sudo apt -y install curl python3
    pip install --user poetry
    # shellcheck disable=1090
    if which poetry;  then echo "found poetry in PATH"; else source ~/.profile; fi
    poetry install
}

os:s1() {
    poetry shell
    ansible-playbook --version
}

help() { # print this help message
    printf "\nUsage: %s {task} [...args]\n" "$0"
    printf "Where {task} is:\n"
    printf "\t%s\n"  "${tasksList[@]}" | sort
}

# --------------------------------------

task="$1"

if [ "$task" == "--help" ] || [ "$task" == "help" ]
then
    help
    exit 0
fi

if [ "$task" == "" ]
then
    printf "\n$error you forgot to pass task name\n"
    help
    exit 13
fi



if ! printf "%s\n" "${tasksList[@]}" | grep -E "^$task\s";
then
    printf "\n$error: unknown task: \"%s\"\n" "$task"
    help
    exit 13
fi

printf "$info \"%s\" task running...\n" "$task"
shift 1
# shellcheck disable=SC2068
$task $@
printf "$info \"%s\" task done!\n" "$task"