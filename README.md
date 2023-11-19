# Dotfiles ···
My dotfiles to configure zsh, vim and a few others.

<details>
<summary>Table of Contents</summary>

[[_TOC_]]
</details>

## Install Instructions

<details>
<summary>Automatic</summary>

- Clone the repo
```
git clone https://gitlab.com/AHMZA/dot
```

- Run the installer
```
.dot/dotInstall
```

    <details>
    <summary>Flowchart</summary>
    <br>
    <br>

    ```mermaid
    graph TD;
    Request-Elevated-Permissions-->apt-update-->install-git-->install-zsh-->install-neovim-->End-Elevated-Permissions;
    End-Elevated-Permissions-->Check-if-'./dot'-exists;
    Check-if-'./dot'-exists-->download-repo;
    Check-if-'./dot'-exists-->pull-latest;
    download-repo-->move-files;
    pull-latest-->move-files;
    move-files-->install-packer-->install-vim-plug-->install-antibody-->run-antibody-->set-shell-zsh-->Request-Elevated-Permissions-->delete-source-files-->End-Elevated-Permissions;
    ```
    </details>
</details>

### Manual

- Clone the Repository
```
git clone git@gitlab.com:ahmza/dot.git
```

- Copy downloaded Files/Folders to corresponding locations on local device

- Install the following packages
 - https://github.com/wbthomason/packer.nvim
 - https://github.com/junegunn/vim-plug
 - https://getantibody.github.io/install/
 - https://github.com/spaceship-prompt/spaceship-prompt

- Generate zsh plugins
```
antibody bundle < ~/.zsh_plugins > ~/.zsh_plugins.sh
```

- Make zsh your default shell
```
chsh -s $(which zsh)
```

- Logout and Login

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

## Setting up bare repo
- Setup a git bare repo
```
git init --bare $HOME/.dot
```
- Alias incase it gets removed from alias ...
```
alias dotconf='/usr/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME'
```
- Dont show untracked files
```
config --local status.showUntrackedFiles no
```

## To Do
- [ ] keybindings for markdown-preview

## Questions ?
[contact:support@ahmza.com]