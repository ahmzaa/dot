# tmux

tmux config plus helper scripts. Prefix is remapped to `C-a`.

## Files

| File | Purpose |
|------|---------|
| `.config/tmux/tmux.conf` | Main config |
| `bin/tmux-sessionizer` | fzf project switcher (creates/attaches a session per dir) |
| `bin/tmux-cht.sh` | [cht.sh](https://cht.sh) cheatsheet lookup in a new window |
| `.config/tmux/tmux-cht-language` | Language list for `tmux-cht.sh` |
| `.config/tmux/tmux-cht-command` | Command list for `tmux-cht.sh` |

`bin/` is on `$PATH` (via the `shell` package), so `tmux-sessionizer` is callable
directly (also used by the nvim `<leader>ts` binding).

## Key binds

Prefix = `C-a`.

| Bind | Action |
|------|--------|
| `prefix r` | Reload config |
| `prefix h/j/k/l` | Move between panes (vim-style) |
| `prefix ^` | Last window |
| `prefix f` | tmux-sessionizer (pick any project) |
| `prefix U` | Sessionizer scoped to `~/prj/tea.ahmza.com/ahmza` |
| `prefix I` | Sessionizer scoped to `~/prj/github.com/ahmzaa` |
| `prefix i` | cht.sh lookup |
| `v` / `y` (copy-mode) | Begin selection / yank to system clipboard |
