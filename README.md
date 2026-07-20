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

The `install` script installs these for you. Zsh plugins are also cloned
automatically on first shell start into `~/.zsh/plugins`
(zsh-autosuggestions, zsh-syntax-highlighting, zsh-completions, fzf-tab).

## Install

Clone the repo (anywhere — the installer auto-detects its location):

```sh
git clone git@github.com:ahmzaa/dot.git ~/dot
cd ~/dot
```

### Guided install (recommended)

Run the interactive installer:

```sh
./install
```

It will:

- **Detect your OS and package manager** — macOS (Homebrew, auto-installed
  if missing) or Linux (`apt`, `pacman`, or `dnf`).
- **Install a curated set of core dependencies** — git, stow, zsh, starship,
  fzf, ripgrep, fd, lsd, lolcat, yazi, tmux.
- **Let you choose what to stow** via a menu (uses `gum` or `fzf` if
  available, otherwise a numbered prompt). Pick individual packages or a
  predefined group:
  - `core` — zsh, shell, nvim, starship, tmux, bin, ssh, xdg-dirs, yazi
  - `desktop-linux` — hypr, waybar, dunst, tofi, wal, foot, MangoHud
  - `desktop-macos` — aerospace, ghostty
  - `all` — everything
- **Install per-package dependencies** for your selection (e.g. Hyprland for
  the `hypr` package).
- **Check neovim** — compares the packaged version against the latest stable
  release and warns if the packaged one is behind.
- **Stow your selection** and, if you agree, **set zsh as your login shell**
  (adding it to `/etc/shells` first when needed).

It is safe to re-run; stow is applied with `--restow`.

### Manual install

If you'd rather do it by hand:

```sh
# install deps with your package manager, then:
stow */          # everything
stow zsh nvim    # or specific packages
chsh -s "$(command -v zsh)"
```

## Host-specific config

`zsh` detects the OS and hostname (`zsh/.config/zsh/os-specific.sh`) and sources
a matching file from `zsh/.config/zsh/hosts/`. See the
[zsh README](zsh/.config/zsh/README.md) for details.

## Docs

- [SSH agent & certificate setup](docs/ssh-cert-setup.md)

## Questions?

[support@ahmza.com](mailto:support@ahmza.com)
