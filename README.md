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
| `sesh` | [sesh](https://github.com/joshmedeski/sesh) tmux session manager |
| `rmpc` | Music player client |
| `opencode` | [opencode](https://opencode.ai) agents, config & MCP servers (engram, gitea-mcp) |
| `ssh` | Managed `~/.ssh/config` (agent/keychain + CA host) — [README](ssh/README.md) |
| `bin` | Assorted helper scripts — [README](bin/README.md) |
| `xdg-dirs` | XDG user directory config |
| `MangoHud` | Gaming HUD (Linux) |
| `work` | Work-laptop-only overrides (opt-in; gitignored secrets) — see [Host-specific config](#host-specific-config) |
| `ca` | SSH CA host signing script (`sign-key`) — CA host only, opt-in; see [docs/ssh-cert-setup.md](docs/ssh-cert-setup.md) |

## Requirements

**Essential**
- [GNU Stow](https://www.gnu.org/software/stow/)
- [zsh](https://www.zsh.org/)

**Common CLI tools**
- [starship](https://starship.rs), [fzf](https://github.com/junegunn/fzf), [ripgrep](https://github.com/BurntSushi/ripgrep), [fd](https://github.com/sharkdp/fd)
- [lsd](https://github.com/lsd-rs/lsd), [lolcat](https://github.com/busyloop/lolcat), [yazi](https://github.com/sxyazi/yazi)
- [zoxide](https://github.com/ajeetdsouza/zoxide) (smart `cd`, used by `.zshrc` and `sesh`)
- [neovim](https://github.com/neovim/neovim) (uses [lazy.nvim](https://github.com/folke/lazy.nvim))

The `install` script installs these for you. Zsh plugins are also cloned
automatically on first shell start into `~/.zsh/plugins`
(zsh-autosuggestions, zsh-syntax-highlighting, zsh-completions, fzf-tab).

Shell-integrated tools (`fzf`, `zoxide`, `starship`) are loaded conditionally in
`.zshrc`; if any are missing you'll see a single `⚠ missing tools:` line at
shell startup instead of an error — run `./install` to fix.

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
- **Install a curated set of core dependencies** — git, stow, zsh, fzf,
  ripgrep, fd, lsd, lolcat, tmux, zoxide (starship, yazi, sesh and opencode
  are installed only if you select their package).
- **Let you choose what to stow** via a menu (uses `fzf` if available,
  otherwise a numbered prompt). Pick individual packages or a
  predefined group:
  - `core` — zsh, shell, nvim, starship, tmux, bin, ssh, xdg-dirs, yazi, sesh
  - `desktop-linux` — hypr, waybar, dunst, tofi, wal, foot, MangoHud
  - `desktop-macos` — aerospace, ghostty
  - `work` — the `work` package (CoreWeave laptop; opt-in, excluded from `all`)
  - `all` — everything except `work`
- **Install per-package dependencies** for your selection (e.g. Hyprland for
  the `hypr` package, the sesh binary for `sesh`, or the engram + gitea-mcp
  MCP servers for `opencode`).
- **Check neovim** — compares the packaged version against the latest stable
  release; if the packaged one is behind you can install the official
  prebuilt binary instead (into `~/.local`).
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
a matching file from `zsh/.config/zsh/hosts/` (each source is guarded so a
missing host file is a no-op). See the
[zsh README](zsh/.config/zsh/README.md) for details.

### The `work` package

Work-laptop-only configuration is isolated in its own Stow package so the rest
of the repo stays generic. It is **excluded from `all`** and only installed if
you explicitly pick the `work` group.

```sh
stow work        # on the work laptop only
```

It provides:

- `work/.config/zsh/hosts/CW-DYQN400C5P-L` — the work host file (sourced by
  `os-specific.sh` on that hostname). Sources `~/.config/work/secrets`, exports
  `OPENCODE_CONFIG` (see below), and sets up fleet tooling.
- `work/.config/opencode/opencode.work.jsonc` — an **overlay** layered on top of
  the base opencode config via `OPENCODE_CONFIG`. opencode merges configs, so
  the base MCP servers stay active and work-only servers are added. Internal
  URLs come from `{env:...}` vars defined in the secrets file.
- `work/.config/sesh/sesh.toml` — a full sesh config (base + work sessions).
  Because sesh reads a single file, on the work laptop you stow `work` but **not**
  the base `sesh` package (the installer drops `sesh` automatically if you pick
  both).
- `work/.config/work/secrets` — **gitignored**; holds internal URLs/tokens. Copy
  `secrets.example` to `secrets` and fill it in on the work machine.

### opencode & MCP servers

The `opencode` package ships the config, agents, plugins, and two local MCP
servers referenced by `opencode.jsonc`:

- [engram](https://github.com/Gentleman-Programming/engram) — persistent memory
- [gitea-mcp](https://gitea.com/gitea/gitea-mcp) — Gitea integration

Selecting `opencode` in the installer installs opencode itself, then downloads
the official prebuilt binaries for both MCP servers into `~/.local/bin`
(falling back to `go install`). Both servers are referenced by bare command name,
so they resolve from `PATH` on any machine.

After stowing, the installer runs `engram setup opencode`, which generates
`plugins/engram.ts`. That file is **not tracked by this repo** — it is gitignored
and regenerated per host, because engram bakes a host-specific binary path into it
(a `/nix/store/...` path where engram comes from nix, `~/.local/bin` elsewhere).
Stow folds `~/.config/opencode` into a symlink back into this repo, so the command
writes through it; tracking the result meant a permanently dirty working tree that
churned on every engram upgrade. On a fresh machine, run `engram setup opencode`
(or the installer) to produce it.

## Docs

- [SSH agent & certificate setup](docs/ssh-cert-setup.md)

## Questions?

[support@ahmza.com](mailto:support@ahmza.com)
