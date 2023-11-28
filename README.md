# Dotfiles ···
Dotfiles to configure zsh, neovim and a few others.

[[_TOC_]]

## Features
- ZSH
  - Antibody
  - Starship
- Neovim
  - [README](.config/nvim/README.md)

## Install Instructions

### Requirements
<details>
<summary>Requirements</summary>

- stow (install the dotfiles with ease)
- for zsh
 - [antibody](https://getantibody.github.io/install)
 - [starship](https://starship.rs/guide/#%F0%9F%9A%80-installation)
- for nvim
 - [lazynvim](https://github.com/folke/lazy.nvim)
 - ripgrep (use package manager)
</details>

<details>
<summary>Automatic</summary>

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

</details>

## alias usage

### list
- `ls` - `ls -1 --color`
- `ll` - `ls -lh --color`
- `la` - `ls -alh --color`

### neovim
- `vim` - `nvim`
- `vi` - `nvim`

### git (gx)
- `ga` - `git add`
- `gp` - `gitpush()` - git pull & git push
- `gs` - `git status`
- `gc` - `git commit`

### docker
- `dc` - `docker compose`
- `dcu` - `docker compose up`
- `dcd` - `docker compose down`

### dotfiles
- `dotconf` - `/usr/bin/git --git-dir=$HOME/.dot --work-tree=$HOME`

## To Do
- [ ] keybindings for markdown-preview

## Questions ?
[contact:support@ahmza.com]
