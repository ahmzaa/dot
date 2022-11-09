
## Dotfiles
These are the minimum required dot files (in my opinion) to get a good looking shell and i3 environment quickly and easily.

## prerequisites
* I use alacritty, if you use something else make sure it's covered by i3-sensible-terminal (or change it in .config/i3/config)
* Install picom as the compositor (or change it in .config/i3/config)

## Install Instructions
* `git clone https://gitlab.com/AHMZA/dot`
* Make sure zsh is installed
* Copy downloaded Files/Folders to corresponding locations on local device
* Install: https://github.com/wting/autojump
* Install: https://getantibody.github.io/install/
* run: `antibody bundle < ~/.zsh_plugins > ~/.zsh_plugins.sh`
* activate zsh: `chsh -s $(which zsh)`
* Logout and Login
