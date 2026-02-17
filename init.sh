#!/bin/bash
set -e

echo "🚀 Bootstrapping Environment for vgravdal..."

# Ensure /etc/apt/keyrings exists for modern GPG handling
sudo mkdir -p -m 755 /etc/apt/keyrings

# Install Ansible
echo "📦 update package manager apt..."
sudo apt update

echo "📦 installing Ansible..."
sudo apt install -y software-properties-common
if ! command -v ansible &> /dev/null; then
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install -y ansible
fi

# Run the Playbook
# We use --ask-become-pass so you can enter your sudo password once

echo "📋 Running Ansible playbook to set up the environment for basic utility tools..."
ansible-playbook set-up.yaml --ask-become-pass

# Ask about devops tools installation
read -p "🔧 Do you want to install devops tools? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "📦 Installing devops tools..."
    ./devops-tools.sh
fi

if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo "🚫 Skipping devops tools installation."
    echo "✅ All set! Restarting your terminal by running 'source ~/.bashrc'."
    source ~/.bashrc
fi
