# zsh configuration

Cross-platform zsh setup. Plugins are managed manually (cloned into
`~/.zsh/plugins` on first start) — **not** oh-my-zsh.

## Layout

| File | Purpose |
|------|---------|
| `.zshrc` | Main interactive config (completion, options, plugins, binds) |
| `.zshenv` | Env exports, `typeset -U path fpath` |
| `os-specific.sh` | Detects OS/hostname and sources the matching `hosts/` file |
| `hosts/` | Per-host config (`mac`, `shadow`, `cloudtop`, `CW-DYQN400C5P-L`, …) |
| `ssh-agent` | OS-aware agent bootstrap (macOS Keychain / Linux persistent agent) |
| `ssh-cert` | SSH certificate expiry check + auto-renewal (see [docs](../../../docs/ssh-cert-setup.md)) |

Shell-agnostic pieces live in the `shell` package (`shell/.config/shell/`):
`alias`, `path`, and a gitignored `vars`.

## Plugins

Loaded from `~/.zsh/plugins` (auto-cloned if missing):

- zsh-autosuggestions
- zsh-syntax-highlighting (sourced last, so it wraps all widgets)
- zsh-completions (added to `$fpath` before `compinit`)
- [fzf-tab](https://github.com/Aloxaf/fzf-tab)

Prompt is [starship](https://starship.rs); `fzf` and completions are loaded in
`.zshrc`.

## Alias usage

### General
- `vi` / `vim` → `nvim`
- `ls` → `lsd -1 --icon=never`
- `ll` → `lsd -lh --icon=never`
- `la` → `lsd -alh --icon=never`
- `grep` → `rg`

### Git
- `ga` → `git add`
- `gp` → `gitpush()` (git pull && git push)
- `gs` → `git status`
- `gc` → `git commit`

### Docker
- `dc` → `docker-compose`
- `dcu` → `docker-compose up -d`
- `dcd` → `docker-compose down`

### Kubernetes
- `kubectl` / `k` → `kubecolor`

### Yazi
- `y` → open yazi and cd into its last directory on exit

## Key binds

- `^a` / `^e` — start / end of line
- `^H` — backward kill word
- `^J` / `^K` — history search forward / backward
- `^R` — fzf history widget
- `^f` — open `fff` file manager

## Questions?

[support@ahmza.com](mailto:support@ahmza.com)
