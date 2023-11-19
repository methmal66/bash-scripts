#!/bin/bash

# Author: Sanuja Methmal
# Description: This script will automate every step you need to connect to a
#              ssh server using key based authentication. It will ask to confirm 
#              the fingerprint and enter the password at the first time connecting
#              to the server.
# Usage:
#       init_ssh_con.sh

REMOTE_USER=methmal
TARGET=serverb
PORT=22
KEY="/home/${USER}/.ssh/id_${REMOTE_USER}@${TARGET}_rsa" # Relative path doesn't work with ssh

echo "[$(date)]" >> output


# Generate a new ssh key
if ! [ -e $KEY ]; then
        ssh-keygen -f $KEY -t rsa -b 2048 -N "" >> output 2>> output
        echo "" >> output
        echo "New SSH key generated"
fi

# Copy the new key
ssh-copy-id -p $PORT -i $KEY $REMOTE_USER@$TARGET >> output 2>> output
echo "SSH key copied to the server"

# Connect using ssh
echo "Connecting to the server..."
ssh -i $KEY $REMOTE_USER@$TARGET
