
## Install Instructions
* when cloning use the recurse submodule option
* git clone --recurse-submodules -j8 https://github.com/4hmz4/dots
* Make sure zsh is installed (wouldnt activate it yet)
* Copy Files/Folders to locations on local device
* Install: https://github.com/wting/autojump
* change the autojump python files in ~/.autojump/bin to use python3
* Install: https://getantibody.github.io/install/
* antibody bundle < ~/.zsh_plugins > ~/.zsh_plugins.sh
* for spaceship do: ln -sf "$PWD/spaceship.zsh" "/usr/local/share/zsh/site-functions/prompt_spaceship_setup"
* activate zsh: chsh -s $(which zsh)
* Source .zshrc
