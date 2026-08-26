# bin

Helper scripts installed to `~/bin` (on `$PATH` via the `shell` package).

| Script | Purpose |
|--------|---------|
| `launch-waybar` | Start/restart [waybar](https://github.com/Alexays/Waybar), killing any existing instance (Linux) |
| `passmenu` | dmenu/rofi front-end for [pass](https://www.passwordstore.org/); `--type` types the password instead of copying |
| `swp` | Set wallpaper, caching processed images under `$XDG_CACHE_HOME/wallpp_cache` |
| `ssh-cert` | Run the SSH certificate expiry check/renewal helper from the `zsh` package |
| `uwsm-hyprlauncher` | Launch Hyprland via [uwsm](https://github.com/Vladimir-csp/uwsm) |

> The implementation lives at `zsh/.config/zsh/ssh-cert`; the `bin` package
> provides the command on `$PATH`.
