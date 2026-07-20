# Dotfiles ···

Cross-platform (macOS + Linux) dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

Each top-level directory is a Stow package whose contents mirror `$HOME`.

## Packages

| Package | Description |
|---------|-------------|
| `zsh` | Zsh config, host-specific settings, SSH agent/cert scripts — [README](zsh/.config/zsh/README.md) |
| `shell` | Shell-agnostic `alias`, `path`, and (gitignored) `vars` — [README](shell/README.md) |
| `nvim` | Neovim (lazy.nvim) — [README](nvim/.config/nvim/README.md) |
| `starship` | [Starship](https://starship.rs) prompt (kubernetes/teleport aware) |
| `tmux` | tmux config + `tmux-sessionizer` — [README](tmux/README.md) |
| `ghostty` / `foot` | Terminal emulators (macOS / Linux) |
| `aerospace` | [AeroSpace](https://github.com/nikitabobko/AeroSpace) tiling WM (macOS) |
| `hypr` | [Hyprland](https://github.com/hyprwm/Hyprland) compositor (Linux) — [README](hypr/.config/hypr/README.md) |
| `waybar` / `dunst` / `tofi` / `wal` | Wayland bar, notifications, launcher, pywal (Linux) |
| `yazi` | [Yazi](https://github.com/sxyazi/yazi) file manager |
| `rmpc` | Music player client |
| `opencode` | [opencode](https://opencode.ai) agents & config |
| `ssh` | Managed `~/.ssh/config` (agent/keychain + CA host) — [README](ssh/README.md) |
| `bin` | Assorted helper scripts — [README](bin/README.md) |
| `xdg-dirs` | XDG user directory config |
| `MangoHud` | Gaming HUD (Linux) |

## Requirements

**Essential**
- [GNU Stow](https://www.gnu.org/software/stow/)
- [zsh](https://www.zsh.org/)

**Common CLI tools**
- [starship](https://starship.rs), [fzf](https://github.com/junegunn/fzf), [ripgrep](https://github.com/BurntSushi/ripgrep), [fd](https://github.com/sharkdp/fd)
- [lsd](https://github.com/lsd-rs/lsd), [lolcat](https://github.com/busyloop/lolcat), [yazi](https://github.com/sxyazi/yazi)
- [neovim](https://github.com/neovim/neovim) (uses [lazy.nvim](https://github.com/folke/lazy.nvim))

Zsh plugins are cloned automatically on first shell start into `~/.zsh/plugins`
(zsh-autosuggestions, zsh-syntax-highlighting, zsh-completions, fzf-tab).

## Install

Clone the repo:

```sh
git clone git@github.com:ahmzaa/dot.git ~/dot
cd ~/dot
```

Stow everything, or individual packages:

```sh
# all packages
stow */

# a single package
stow zsh
stow nvim
```

Make zsh your default shell:

```sh
chsh -s $(which zsh)
```

There is also an `install` script that bootstraps the basics on Debian/Ubuntu
(zsh, stow, neovim, and friends).

## Host-specific config

`zsh` detects the OS and hostname (`zsh/.config/zsh/os-specific.sh`) and sources
a matching file from `zsh/.config/zsh/hosts/`. See the
[zsh README](zsh/.config/zsh/README.md) for details.

## Docs

- [SSH agent & certificate setup](docs/ssh-cert-setup.md)

## Questions?

[support@ahmza.com](mailto:support@ahmza.com)
