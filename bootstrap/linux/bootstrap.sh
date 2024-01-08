#!/bin/bash

if [ -z "$DESIRED_USER" ]; then
    echo "Please set DESIRED_USER environment variable to the desired user name"
    exit 1
fi

# Check if desired user already exists
if [ "$DESIRED_USER" == "$USER" ]; then
    echo "Current user is the desired user, nothing to do."
    exit 1
fi

if [ -d "/home/$DESIRED_USER" ]; then
    echo "User $DESIRED_USER already exists, skip creating."
else
    echo "Creating user $DESIRED_USER:"
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

# Done
echo "User $DESIRED_USER is ready."
echo "Please login as $DESIRED_USER and delete current user with \"sudo userdel -r $USER\" if you don't need it anymore."