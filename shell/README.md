# shell

Shell-agnostic configuration sourced by `.zshrc` (and usable from any
POSIX-ish shell). Kept separate from `zsh` so it can be shared.

| File | Purpose |
|------|---------|
| `alias` | Aliases and small functions (nvim, lsd, git, docker, kubecolor, yazi) |
| `path` | `$PATH` exports (`~/bin`, `~/.local/bin`, go, cargo) |
| `vars` | Machine-local / secret env vars — **gitignored**, not committed |

`vars` is where per-machine secrets live (e.g. the SSH CA host/user used by
`ssh-cert`). Create it locally; it is intentionally excluded from the repo.

Sourced near the top of `.zshrc`:

```sh
[ -f "$XDG_CONFIG_HOME/shell/alias" ] && source "$XDG_CONFIG_HOME/shell/alias"
[ -f "$XDG_CONFIG_HOME/shell/vars" ]  && source "$XDG_CONFIG_HOME/shell/vars"
[ -f "$XDG_CONFIG_HOME/shell/path" ]  && source "$XDG_CONFIG_HOME/shell/path"
```
