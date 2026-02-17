#!/bin/bash
set -e

echo "🚀 Bootstrapping Environment for vgravdal..."

# Ensure /etc/apt/keyrings exists for modern GPG handling
sudo mkdir -p -m 755 /etc/apt/keyrings

# Install Ansible
sudo apt update
sudo apt install -y software-properties-common
if ! command -v ansible &> /dev/null; then
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install -y ansible
fi

# Run the Playbook
# We use --ask-become-pass so you can enter your sudo password once
ansible-playbook set-up.yaml --ask-become-pass

echo "✅ All set! Restarting your terminal running 'source ~/.bashrc'."

source ~/.bashrc