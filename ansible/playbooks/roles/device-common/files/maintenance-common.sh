#!/bin/bash

# Upgrade packages
sudo apt update
sudo apt upgrade -y

# Update configurations
cd /home/r12f/config && git pull

# Clean up unused docker images
docker image prune -a -f