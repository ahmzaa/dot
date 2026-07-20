# Hyprland configuration

[Hyprland](https://github.com/hyprwm/Hyprland) compositor config (Linux).

Uses the Lua config format (`hyprland.lua`) plus modular `.conf` files:

| File | Purpose |
|------|---------|
| `hyprland.lua` | Main config |
| `rules.conf` | Window rules |
| `game-rules.conf` | Gaming-specific window rules |
| `hypridle.conf` | Idle daemon (hypridle) |
| `hyprlock.conf` | Lock screen (hyprlock) |
| `hyprsunset.conf` | Blue-light / colour temperature |
| `laptop.conf` | Laptop-specific settings |
| `mocha.conf` / `rose-pine-moon.conf` | Colour themes |

Related packages: `waybar` (bar), `dunst` (notifications), `tofi` (launcher),
`wal` (pywal colours).
