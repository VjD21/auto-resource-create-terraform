#!/bin/bash

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"


# Detect the operating system and install 'unzip' accordingly

if [ -f /etc/debian_version ]; then

    echo "Detected Debian-based system. Installing 'unzip' with apt."
    sudo apt update -y && sudo apt install unzip -y

elif [ -f /etc/redhat-release ]; then

    echo "Detected RHEL-based system. Installing 'unzip' with yum."
    sudo yum install unzip -y
    
else
    echo "Unsupported OS. Installation aborted."
    exit 1
fi

# Confirm installation success

if command -v unzip &> /dev/null; then
    echo "Unzip installation successful."
else
    echo "Unzip installation failed."
    exit 1
fi


unzip awscliv2.zip
sudo ./aws/install
