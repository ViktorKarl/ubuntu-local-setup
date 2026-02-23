# ubuntu-local-setup

Ansible-based provisioning for fresh Ubuntu instances. Run once to get a fully configured development environment.

## Quick Start

```bash
git clone https://github.com/ViktorKarl/ubuntu-local-setup.git && cd ubuntu-local-setup && chmod +x init.sh devops-tools.sh && ./init.sh

# DevOps tools (optional, run separately)
./devops-tools.sh
```

`init.sh` installs Ansible (via PPA), then runs the base playbook. At the end it prompts whether to also install DevOps tools. `devops-tools.sh` can be run independently at any time.

Run specific parts with tags:

```bash
ansible-playbook set-up.yaml --ask-become-pass --tags shell,git
ansible-playbook devops-tools.yaml --ask-become-pass --tags kubectl,helm
```

---

## What's Included

### `set-up.yaml` — Base Environment

#### CLI Tools (tag: `base`)

| Package | Binary | Description |
|---|---|---|
| tree | `tree` | Directory tree listing |
| fzf | `fzf` | Fuzzy finder |
| htop | `htop` | Interactive process viewer |
| curl | `curl` | URL transfer tool |
| wget | `wget` | File downloader |
| git | `git` | Version control |
| gh  | `gh` | github cli |
| gpg | `gpg` | GNU Privacy Guard |
| ca-certificates | — | Common CA certificates |
| jq | `jq` | JSON processor |
| yq | `yq` | YAML processor |
| ripgrep | `rg` | Fast recursive grep |
| bat | `batcat` | Cat with syntax highlighting (Ubuntu names it `batcat`) |
| unzip | `unzip` | Archive extraction |
| net-tools | `ifconfig`, `netstat` | Classic networking utilities |
| shellcheck | `shellcheck` | Shell script linter |
| tmux | `tmux` | Terminal multiplexer |
| bash-completion | — | Programmable completion framework |

#### Shell Config (tag: `shell`)

| Feature | Detail |
|---|---|
| Aliases | `ll` → `ls -alF`, `g` → `git`, `t` → `terraform`, `k` → `kubectl` |
| `sysupdate` alias | Runs `apt update`, `full-upgrade`, `autoremove`, `autoclean` in sequence |
| fzf keybindings | `Ctrl+R` history search, `Ctrl+T` file search, `Alt+C` cd into directory |

#### Syntax Highlighting (tags: `shell`, `syntax`)

| Component | Detail |
|---|---|
| [ble.sh](https://github.com/akinomyoga/ble.sh) | Real-time syntax highlighting as you type |
| Recognised commands | Bold green |
| Unrecognised commands | Bold red (typo indicator) |
| Keywords | Bold cyan |
| Auto-suggestions | Disabled |
| `[ble: exit N]` marker | Disabled |

Build dependencies (`make`, `gawk`) are installed automatically. ble.sh is cloned to `~/.local/src/ble.sh` and installed to `~/.local/share/blesh/`. Config lives in `~/.config/blesh/init.sh`.

#### Completions (tag: `completions`)

| Completion | Detail |
|---|---|
| bash-completion | Sourced from `/usr/share/bash-completion/bash_completion` |
| git | Sourced + wired to the `g` alias via `__git_complete` |

#### Git Config (tag: `git`)

| Setting | Value |
|---|---|
| `init.defaultBranch` | `main` |
| `user.name` | `ViktorKarl` |
| `user.email` | `viktorkg98@gmail.com` |

---

### `devops-tools.yaml` — DevOps Tooling (optional)

#### Go (tags: `go`, `golang`)

| Detail | Value |
|---|---|
| Install | Official tarball from [go.dev](https://go.dev/dl/) (latest stable) |
| Location | `/usr/local/go` |
| Architecture | Auto-detected (`amd64` / `arm64`) |
| `GOPATH` | `$HOME/go` |
| PATH | Set via `/etc/profile.d/golang.sh` |

#### Podman (tags: `podman`, `containers`)

| Detail | Value |
|---|---|
| Install | `apt install podman` |
| Alias | `docker` → `podman` (added to `~/.bashrc`) |

#### kubectl (tags: `kubectl`, `kubernetes`)

| Detail | Value |
|---|---|
| Install | Direct binary download (latest stable) |
| Location | `/usr/local/bin/kubectl` |
| Architecture | Auto-detected (`amd64` / `arm64`) |

#### Helm (tags: `helm`, `kubernetes`)

| Detail | Value |
|---|---|
| Install | Official `get-helm-3` script |
| Location | `/usr/local/bin/helm` |

#### Terraform (tags: `terraform`, `iac`)

| Detail | Value |
|---|---|
| Install | HashiCorp apt repo + GPG key |
| Location | `/usr/bin/terraform` |

#### Azure CLI (tags: `azure`, `cloud`)

| Detail | Value |
|---|---|
| Install | Microsoft apt repo + GPG key |
| Binary | `az` |

#### DevOps Completions (tag: `completions`)

| Tool | Detail |
|---|---|
| kubectl | System-wide + dynamic completion; wired to `k` alias |
| Helm | System-wide + dynamic completion |
| Terraform | `terraform -install-autocomplete` (adds `complete -C` to `~/.bashrc`) |

---

## Available Tags

### `set-up.yaml`
| Tag | Scope |
|---|---|
| `base` | apt packages (CLI, networking, dev utilities) |
| `shell` | Aliases, fzf keybindings, ble.sh syntax highlighting |
| `syntax` | ble.sh syntax highlighting only |
| `completions` | bash-completion, git completions |
| `git` | Global git configuration |

### `devops-tools.yaml`
| Tag | Scope |
|---|---|
| `go`, `golang` | Go toolchain |
| `podman`, `containers` | Podman + docker alias |
| `kubectl`, `kubernetes` | kubectl binary |
| `helm`, `kubernetes` | Helm 3 |
| `terraform`, `iac` | Terraform via HashiCorp repo |
| `azure`, `cloud` | Azure CLI via Microsoft repo |
| `completions` | Tab completions for all DevOps tools |

---

## Project Structure

```
.
├── init.sh                 # Bootstrap: installs Ansible, runs base playbook, prompts for DevOps
├── devops-tools.sh         # Standalone DevOps tools installer
├── set-up.yaml             # Base environment playbook
├── devops-tools.yaml       # DevOps tools playbook
├── vars/
│   └── main.yaml           # Shared variables (user, home, deb architecture)
└── tasks/
    ├── base-tools.yaml          # apt packages (CLI, networking, dev utilities)
    ├── shell-config.yaml        # Aliases, fzf keybindings
    ├── completions.yaml         # bash-completion, git completions
    ├── git-config.yaml          # git global config
    ├── syntax-highlighting.yaml # ble.sh build, install & config
    ├── go.yaml                  # Go toolchain
    ├── podman.yaml              # Podman + docker alias
    ├── kubectl.yaml             # kubectl binary
    ├── helm.yaml                # Helm 3
    ├── terraform.yaml           # Terraform via HashiCorp repo
    ├── azure-cli.yaml           # Azure CLI via Microsoft repo
    └── devops-completions.yaml  # Tab completions for DevOps tools
```

Happy configuring! 
