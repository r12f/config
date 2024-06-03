#!/bin/bash

# Upgrade packages
sudo apt update
sudo apt upgrade -y

# Update configurations
cd /home/r12f/config && git pull
