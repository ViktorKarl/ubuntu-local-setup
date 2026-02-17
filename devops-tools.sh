#!/bin/bash
set -e

echo "🚀 Installing DevOps tools (kubectl, podman, Helm, Terraform)..."

# Ensure /etc/apt/keyrings exists for modern GPG handling
sudo mkdir -p -m 755 /etc/apt/keyrings

# Install Ansible if not present
if ! command -v ansible &> /dev/null; then
    sudo apt update
    sudo apt install -y software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install -y ansible
fi

# Run the DevOps tools playbook
ansible-playbook devops-tools.yaml --ask-become-pass

echo "✅ All set! Restarting your terminal by running 'source ~/.bashrc'."

source ~/.bashrc