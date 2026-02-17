# ubuntu-local-setup

Ansible-based provisioning for fresh Ubuntu instances. Run once to get a fully configured development environment.

## What's Included

### `set-up.yaml` — Base environment
| Category | Tools |
|---|---|
| Containers | Podman (aliased as `docker`) |
| Editor | VS Code |
| CLI | tree, fzf, htop, ripgrep, bat, jq, tmux, shellcheck, bash-completion |
| Networking | curl, wget, net-tools |
| Dev utilities | git, gpg, ca-certificates, unzip |
| Shell config | aliases (`ll`, `g`, `t`, `k`, `sysupdate`), fzf keybindings, git completions, `EDITOR=code` |
| Git | default branch set to `main` |

### `devops-tools.yaml` — DevOps tooling (optional)
| Category | Tools |
|---|---|
| Kubernetes | kubectl, Helm |
| IaC | Terraform |
| Cloud | Azure CLI |

## Usage

```bash
git clone https://github.com/ViktorKarl/ubuntu-local-setup.git && cd ubuntu-local-setup && chmod +x init.sh devops-tools.sh && ./init.sh

# DevOps tools (optional, run separately)
./devops-tools.sh
```

`init.sh` installs Ansible, then runs the base playbook. `devops-tools.sh` adds kubectl, Helm, Terraform, and Azure CLI on top.
