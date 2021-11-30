
## Dotfiles
These are the minimum required dot files (in my opinion) to get a good looking shell and i3 environment quickly and easily. I am working on a script to automate the process listed below.

## prerequisites
* Install dust as a replacement for du (or change in .zsh/aliases)
* Install ripgrep as a replacement for grep (or change in .zsh/aliases)
* I use alacritty, if you use something else make sure it's covered by i3-sensible-terminal (or change it in .config/i3/config)
* Install picom as the compositor (or change it in .config/i3/config)

## Install Instructions
* git clone https://github.com/4hmz4/dot
* Make sure zsh is installed (dont activate it yet)
* Copy downloaded Files/Folders to corresponding locations on local device
* Install: https://github.com/wting/autojump
* change the autojump python files in ~/.autojump/bin to use python3
    * #!/usr/bin/env/ python3
* Install: https://getantibody.github.io/install/
* run antibody bundle < ~/.zsh_plugins > ~/.zsh_plugins.sh
* activate zsh: chsh -s $(which zsh)
* Logout and Login
