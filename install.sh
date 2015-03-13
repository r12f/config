#!/bin/bash

CONFIG_ROOT=$(cd "$(dirname "$0")"; pwd)

BASH_CONFIG_ROOT="$CONFIG_ROOT/bash"
source $BASH_CONFIG_ROOT/.bashrc

echo "Install configuration ..."

function CreateSymbolLinkWithBackup {
    local source_file=$1
    local dest_file=$2

    if [ -e "$dest_file" -o -h "$dest_file" ]; then
        local backup_id=0
        local backup_file="$dest_file.bak"
        while [ -f "$backup_file" ]; do
            (( backup_id += 1 ))
            backup_file="$dest_file.${backup_id}.bak"
        done

        echo "Backing up \"$dest_file\" to \"$backup_file\" ..."
        if ! mv "$dest_file" "$backup_file"; then
            echo "Create backup failed."
            return 1
        fi
    fi

    echo "Creating symbol link: \"$dest_file\" -> \"$source_file\""
    if ! ln -s "$source_file" "$dest_file"; then
        echo "Creating symbol link failed."
        return 1
    fi

    return 0
}

# Install bash configuration
echo "Install bash configuration ..."

if ! CreateSymbolLinkWithBackup "$BASH_CONFIG_ROOT/.bash_profile" "$HOME/.bash_profile"; then
    echo "Install failed."
    exit 1
fi

if ! CreateSymbolLinkWithBackup "$BASH_CONFIG_ROOT/.bashrc" "$HOME/.bashrc"; then
    echo "Install failed."
    exit 1
fi

echo "Bash configuration installation complete!"
echo ""

# Install VIM configuration
VIM_CONFIG_ROOT="$CONFIG_ROOT/vimrc"
$VIM_CONFIG_ROOT/install.sh
echo ""

echo "Configuration installation complete!"
