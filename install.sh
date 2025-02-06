#!/bin/bash

CONFIG_ROOT=$(cd "$(dirname "$0")"; pwd)

BASH_CONFIG_ROOT="$CONFIG_ROOT/bash"
source $BASH_CONFIG_ROOT/.bashrc

echo "Install configuration ..."

function CreateSymbolLinkWithBackup {
    local source_file=$1
    local dest_file=$2

    if [ -L "$dest_file" ]; then
        echo "Removing existing symbol link: \"$dest_file\" ..."
        rm "$dest_file"
    elif [ -e "$dest_file" ]; then
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
if ! CreateSymbolLinkWithBackup "$BASH_CONFIG_ROOT/.bash_profile" "$HOME/.bash_profile"; then
    echo "Install failed."
    exit 1
fi

if ! CreateSymbolLinkWithBackup "$BASH_CONFIG_ROOT/.bash_aliases" "$HOME/.bash_aliases"; then
    echo "Install failed."
    exit 1
fi

if ! CreateSymbolLinkWithBackup "$BASH_CONFIG_ROOT/.bashrc" "$HOME/.bashrc"; then
    echo "Install failed."
    exit 1
fi

# Install git configuration
if ! CreateSymbolLinkWithBackup "$CONFIG_ROOT/git/.gitconfig" "$HOME/.gitconfig"; then
    echo "Install failed."
    exit 1
fi

# Install tmux configuration
if ! CreateSymbolLinkWithBackup "$CONFIG_ROOT/tmux/.tmux.conf" "$HOME/.tmux.conf"; then
    echo "Install failed."
    exit 1
fi

# Install gdb configuration
if ! CreateSymbolLinkWithBackup "$CONFIG_ROOT/gdb/.gdbinit" "$HOME/.gdbinit"; then
    echo "Install failed."
    exit 1
fi

# Install ansible configuration
if ! CreateSymbolLinkWithBackup "$CONFIG_ROOT/ansible/ansible.cfg" "$HOME/.ansible.cfg"; then
    echo "Install failed."
    exit 1
fi

if ! CreateSymbolLinkWithBackup "$CONFIG_ROOT/ansible/inventory" "$HOME/.ansible_inventory"; then
    echo "Install failed."
    exit 1
fi

if ! CreateSymbolLinkWithBackup "$CONFIG_ROOT/powershell/profile.ps1" "$HOME/.config/powershell/Microsoft.PowerShell_profile.ps1"; then
    echo "Install failed."
    exit 1
fi

# Install VIM configuration
VIM_CONFIG_ROOT="$CONFIG_ROOT/vimrc"
$VIM_CONFIG_ROOT/install.sh
echo ""

echo "Configuration installation complete!"
