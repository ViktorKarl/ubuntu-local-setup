# ubuntu-local-setup

Ansible-based provisioning for fresh Ubuntu instances. Run once to get a fully configured development environment.

## Usage (oneliner)

```bash
git clone https://github.com/ViktorKarl/ubuntu-local-setup.git && cd ubuntu-local-setup && chmod +x init.sh devops-tools.sh && ./init.sh

# DevOps tools (optional, run separately)
./devops-tools.sh
```

`init.sh` installs Ansible, then runs the base playbook. `devops-tools.sh` adds Podman, kubectl, Helm, Terraform, and Azure CLI on top.

Run specific parts with tags: `ansible-playbook set-up.yaml --ask-become-pass --tags shell,git`

## What's Included

### `set-up.yaml` — Base environment
| Category | Tools |
|---|---|
| CLI | tree, fzf, htop, ripgrep, bat, jq, yq, tmux, shellcheck, bash-completion |
| Networking | curl, wget, net-tools |
| Dev utilities | git, gpg, ca-certificates, unzip |
| Shell config | aliases (`ll`, `g`, `t`, `k`, `sysupdate`), fzf keybindings, git completions |
| Git | default branch set to `main` |

### `devops-tools.yaml` — DevOps tooling (optional)
| Category | Tools |
|---|---|
| Containers | Podman (aliased as `docker`) |
| Kubernetes | kubectl, Helm |
| IaC | Terraform |
| Cloud | Azure CLI |

## Project Structure

```
.
├── init.sh                 # Bootstrap script (installs Ansible, runs base playbook)
├── devops-tools.sh         # Optional DevOps tools installer
├── set-up.yaml             # Base environment playbook
├── devops-tools.yaml       # DevOps tools playbook
├── vars/
│   └── main.yaml           # Shared variables (user, home, architecture)
└── tasks/
    ├── base-tools.yaml     # apt packages (CLI, networking, dev utilities)
    ├── shell-config.yaml   # fzf keybindings, bash aliases
    ├── completions.yaml    # bash-completion, git completions
    ├── git-config.yaml     # git global config
    ├── podman.yaml         # Podman + docker alias
    ├── kubectl.yaml        # kubectl binary
    ├── helm.yaml           # Helm 3
    ├── terraform.yaml      # Terraform via HashiCorp repo
    ├── azure-cli.yaml      # Azure CLI via Microsoft repo
    └── devops-completions.yaml  # Tab completions for DevOps tools
```
Happy configure :) 
