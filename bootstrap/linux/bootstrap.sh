#!/bin/bash

if [ -z "$DESIRED_USER" ]; then
    read -p "Please input your user name: " DESIRED_USER
    if [ -z "$DESIRED_USER" ]; then
        echo "Desired user cannot be empty. Please set DESIRED_USER environment variable or input one."
        exit 1
    fi
fi

if [ -z "$DESIRED_HOSTNAME" ]; then
    read -p "Please input your host name: " DESIRED_HOSTNAME
    if [ -z "$DESIRED_HOSTNAME" ]; then
        echo "Desired host name cannot be empty. Please set DESIRED_HOSTNAME environment variable or input one."
        exit 1
    fi
fi

# Check if desired user already exists
if [ "$DESIRED_USER" == "$USER" ]; then
    echo "Current user is the desired user, skip creating."
elif [ -d "/home/$DESIRED_USER" ]; then
    echo "User $DESIRED_USER already exists, skip creating."
else
    echo "Creating user $DESIRED_USER ..."
    sudo useradd -m -s /bin/bash $DESIRED_USER
    sudo passwd $DESIRED_USER
fi

# Add user to all groups of current user
echo "Adding $DESIRED_USER to all groups of $USER:"
for g in `sudo groups $USER | sed "s/^[^:]*: $USER//"`; do
    echo "- $g"
    sudo usermod -a -G $g $DESIRED_USER;
done

# Add user to sudoers
sudo grep -q $DESIRED_USER /etc/sudoers || echo "$DESIRED_USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

# Update hostname
HOSTNAME=`hostname`
echo "Updating hostname to $DESIRED_HOSTNAME ..."
sudo hostnamectl hostname $DESIRED_HOSTNAME
sudo sed -i "s/$HOSTNAME/$DESIRED_HOSTNAME/g" /etc/hosts

# Configurate SSH
echo "Configurating SSH ..."
if [ ! -d "$HOME/.ssh" ]; then
    echo "Creating $HOME/.ssh folder ..."
    mkdir -p "$HOME/.ssh"
fi

if [ ! -f "$HOME/.ssh/authorized_keys" ]; then
    echo "Creating $HOME/.ssh/authorized_keys file ..."
    touch "$HOME/.ssh/authorized_keys"
fi

echo "Upating $HOME/.ssh permission ..."
chmod -R go= "$HOME/.ssh"
sudo chown -R $DESIRED_USER:$DESIRED_USER "$HOME/.ssh"

echo "Upating SSH confgurations ..."
sudo sed -i -e "/PubkeyAuthentication/s/^.*$/PubkeyAuthentication yes/" \
    -e "/PubkeyAuthentication/aAuthorizedKeysFile .ssh\/authorized_keys" \
    -e "/AuthorizedKeysFile/d" \
    -e "/PubkeyAcceptedAlgorithms/d" \
    -e "/PubkeyAuthentication/aPubkeyAcceptedAlgorithms +ssh-rsa" \
    /etc/ssh/sshd_config

echo "Restarting SSH ..."
sudo systemctl restart ssh
sudo systemctl status ssh

# Done
echo "User $DESIRED_USER is ready."
echo "Please login as $DESIRED_USER and delete current user with \"sudo userdel -r $USER\" if you don't need it anymore."