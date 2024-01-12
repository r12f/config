#!/bin/bash

OS_ID=`sed -n '/^ID=/s/ID=//p' /etc/os-release`
OS_CODENAME=`sed -n '/^VERSION_CODENAME=/s/VERSION_CODENAME=//p' /etc/os-release`
OS_RELEASE=`sed -n 's/VERSION_ID="\([^"][^"]*\)"/\1/p' /etc/os-release`
DATA_DIR="$HOME/data"

# Debian system doesn't have release set in /etc/os-release.
if [ "$OS_ID" == "debian" ]; then
    case $OS_CODENAME in
        "bookworm")
            OS_RELEASE="12"
            ;;
        "bullseye")
            OS_RELEASE="11"
            ;;
        "buster")
            OS_RELEASE="10"
            ;;
        *)
            echo "Unsupported OS: $OS_CODENAME"
            exit 1
            ;;
    esac
fi

function main() {
    sudo apt update

    install_common_tools
    install_config
    install_dev_tools

    clean_up
}

function install_common_tools() {
    echo ""
    echo "Install common tools ..."

    sudo apt install -y \
        ca-certificates \
        gnupg \
        bash-completion \
        htop \
        iotop \
        uuid \
        minicom \
        setserial \
        tio \
        wget \
        curl \
        vim \
        jq \
        yq \
        zip \
        lsof \
        net-tools \
        iptables \
        bridge-utils \
        traceroute \
        iperf \
        tcpdump \
        tshark \
        fio \
        stress-ng
}

function install_config() {
    echo ""
    echo "Install configurations ..."

    if [ -d ~/config ]; then
        cd ~/config && git pull && git submodule update --init --recursive && cd -
    else
        git clone https://github.com/r12f/config.git ~/config --recurse-submodules
    fi

    ~/config/install.sh
}

function redirect_large_folders_to_data() {
    # Redirect multiple folders that can be crazily large to home folder, so we can mount it to large disk.
    if [ ! -d "$DATA_DIR" ]; then
        echo "Data folder $DATA_DIR is not found! Creating ..."
        mkdir $DATA_DIR
    fi

    echo "Redirecting large data folder to $HOME/data:"
    redirect_folder "$HOME/.vscode-server" "$DATA_DIR/data/.vscode-server"
    redirect_folder "/var/lib/docker" "$DATA_DIR/data/docker"
}

function redirect_folder() {
    SRC_DIR=$1
    DST_DIR=$2

    echo "Redirecting folder: $DST_DIR => $SRC_DIR"

    if [ ! -d "$DST_DIR" ]; then
        echo "Creating destination folder: $DST_DIR"
        mkdir -p "$DST_DIR"
    fi

    if [ ! -d "$SRC_DIR" ]; then
        echo "Source folder already exist, backing it up to $SRC_DIR.bak."
        mv "$SRC_DIR" "$SRC_DIR.bak"
    fi

    if [ ! -L "$SRC_DIR" ]; then
        echo "Source folder is already created as symlink. Removing."
        rm "$SRC_DIR"
    fi

    echo "Create symlink: $DST_DIR => $SRC_DIR"
    ln -s $SRC_DIR $DST_DIR
}

function install_dev_tools() {
    install_dev_essential_tools
    install_dotnet
    install_python
    install_rust
    install_go
    install_docker
}

function install_dev_essential_tools() {
    echo ""
    echo "Installing dev essential tools ..."

    sudo apt install -y build-essential \
        g++ \
        git \
        cmake \
        libboost-all-dev \
        libpcap-dev \
        pkg-config \
        protobuf-compiler
}

function install_dotnet() {
    echo ""
    echo "Installing dotnet SDK 7.0 ..."

    if ! command -v dotnet &> /dev/null; then
        # Installing source list and etc.
        wget https://packages.microsoft.com/config/$OS_ID/$OS_RELEASE/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
        sudo dpkg -i packages-microsoft-prod.deb
        rm packages-microsoft-prod.deb

        sudo apt update
    fi

    sudo apt install dotnet-sdk-7.0
}

function install_python() {
    echo ""
    echo "Installing python ..."

    sudo apt install -y python3 \
        python3-dev \
        python3-pip \
        python3-setuptools
}

function install_rust() {
    echo ""
    echo "Installing rust ..."

    if command -v rustup &> /dev/null; then
        echo "Rust is already installed. Updating ..."
        rustup update
        return
    fi

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
}

function install_go() {
    echo ""
    echo "Installing GO ..."

    sudo snap install go --classic
}

function install_docker() {
    echo ""
    echo "Installing docker ..."

    if ! command -v docker &> /dev/null; then
        # Add Docker's official GPG key:
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/$OS_ID/gpg | sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
        sudo chmod a+r /etc/apt/keyrings/docker.gpg

        # Add the repository to Apt sources:
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$OS_ID $OS_CODENAME stable" | \
            sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        sudo apt-get update
    fi

    sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

function clean_up() {
    echo ""
    echo "Clean up ..."

    sudo apt autoremove -y
}

main