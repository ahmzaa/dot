# Dotfiles
These are the minimum required dot files (in my opinion) to get a good looking shell and i3 environment quickly and easily.

## prerequisites
* I use alacritty, if you use something else make sure it's covered by i3-sensible-terminal (or change it in .config/i3/config)
* Install picom as the compositor (or change it in .config/i3/config)

## dotInstall
### What
dotInstall will download a basic zsh terminal setup.
It includes configs for
- zsh
- nvim

features:
- zsh
  - antibody
  - ...
- nvim
  - lua config
  - plugins

... Continue to flesh out this part of the readme

## Install Instructions
### Automatic with dotInstall
* Run `git clone https://gitlab.com/AHMZA/dot`
* Run `./dot/dotInstall`

### Manual
* Run `git clone https://gitlab.com/AHMZA/dot`
* Make sure zsh is installed
    * Arch `sudo packman -S zsh`
    * Debian `sudo apt install zsh`
* Copy downloaded Files/Folders to corresponding locations on local device
* Install: https://github.com/wting/autojump
* Install: https://github.com/wbthomason/packer.nvim
* Install: https://github.com/junegunn/vim-plug
* Install: https://getantibody.github.io/install/
* Run: `antibody bundle < ~/.zsh_plugins > ~/.zsh_plugins.sh`
* Activate zsh: `chsh -s $(which zsh)`
* Logout and Login

