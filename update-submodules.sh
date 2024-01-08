#!/bin/bash

REPO_USE_MAIN_BRANCH="gdb/gef"
CONFIG_ROOT=$(cd "$(dirname "$0")"; pwd)

echo "Init all submodules ..."
git submodule update --init --recursive

for submodule in `git submodule | awk '{print $2}'`; do
    echo "Updating submodule: $submodule ..."

    cd "$CONFIG_ROOT/$submodule"
    if echo $REPO_USE_MAIN_BRANCH | grep -w -q "$submodule"; then
        echo "Use main branch for $submodule"
        git checkout main
    else
        echo "Use master branch for $submodule"
        git checkout master
    fi

    git pull --recurse-submodules
done

cd "$CONFIG_ROOT"