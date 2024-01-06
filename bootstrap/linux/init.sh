#!/bin/bash

sudo apt update

# Install common tools
sudo apt install -y iptables \
    iotop \
    bash-completion \
    ca-certificates \
    wget \
    curl \
    vim \
    htop \
    zip \
    lsof \
    net-tools \
    bridge-utils \
    traceroute \
    iperf3 \
    tcpdump \
    minicom \
    fio \
    stress-ng \
    tshark \
    uuid \
    setserial \
    tio \

# Install common dev tools
sudo apt install -y build-essential \
    g++ \
    git \
    cmake \
    libboost-all-dev \
    libpcap-dev \
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    pkg-config \
    protobuf-compiler \

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Go
sudo snap install go --classic

# Install config
if [ -d ~/config ]; then
    cd ~/config && git pull && git submodule update --init --recursive && cd -
else
    git clone https://github.com/r12f/config.git ~/config --recurse-submodules
fi

~/config/install.sh