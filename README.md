# Dotfiles ···
Dotfiles to configure zsh, neovim and a few others.

**(Basic Setup)** = terminal only configuration, great for headless

**(More than the terminal)** = configs for more than the terminal i.e window manager stuffs

## Features

- ZSH [README](zsh/.config/zsh/README.md) (Basic Setup)
- Neovim [README](nvim/.config/nvim/README.md) (Basic Setup)
- Hyprland [README](hypr/.config/hypr/README.md) (More than the terminal)
- Kitty [README](kitty/.config/kitty/README.md) (More than the terminal)
- Rofi [README](rofi/.config/rofi/README.md) (More than the terminal)
- Waybar [README](waybar/.config/waybar/README.md) (More than the terminal)


## Install Instructions

<details>
<summary><h3>Requirements</h3></summary>

### Essential
- stow (use package manager)

### Basic Setup
For zsh
 - zsh (use package manager)
 - [antibody](https://getantibody.github.io/install)
 - [starship](https://starship.rs/guide/#%F0%9F%9A%80-installation)

For nvim
 - [neovim](https://github.com/neovim/neovim)
 - [lazynvim](https://github.com/folke/lazy.nvim)
 - ripgrep (use package manager)

### More than the terminal
 - [Hyprland](https://github.com/hyprwm/Hyprland)
 - [Kitty](https://sw.kovidgoyal.net/kitty/)
 - [Rofi](https://github.com/lbonn/rofi)
 - [Waybar](https://github.com/Alexays/Waybar)

</details>

### Install
- Check the requirements section above.
- Clone the repo
```
git clone https://gitlab.com/AHMZA/dot
```

- Run stow
```
# '*/' basically means all folders / configs
stow */

# to stow a single folder / config
stow <foldername>
# i.e
stow nvim
```

- Generate zsh plugins
```
antibody bundle < ~/.config/zsh/plugins > ~/.zsh_plugins
```

- Make zsh your default shell
```
chsh -s $(which zsh)
```

- Logout and Login


**For more information on each of the configurations, check their respective READMEs**

if you have any questions email me below
[contact:support@ahmza.com]
