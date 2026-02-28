# AHMZA's ZSHRC configuration
# Main zsh settings. env in .zprofile

#                                                    
#                                                    
#                                                    
#              :FffffF`       |fffff|                
#           .~Q@@@@@@@Qe    ?Q@@@@@@@Qz~             
#           S@@@@@@@@@@O    /@@@@@@@@@@@             
#           S@@@@@@@@Q;,'}N',~$Q@@@@@@@@             
#           S@@@@@@Zr  ;@@@@S  `ZM@@@@@@             
#           ';@@@l:    ;@j;@f     ;Q@@j;             
#              'rr/@@@/rr' rrr#@@Orr:                
#             6#@@@@@@@@@#6@@@@@@@@@Q6;              
#      /@/rrO@@@@@@@@@@@@#6@@@@@@@@@@@@@rrr#Q        
#      ,\Q@@@@@@@@@@@@@B\, \k@@@@@@@@@@@@@@Sr        
#        ```cDDDDDDDc```     ``,HDDDDDDD```          
#              :FFl              :ff|                
#              /@@Q~.           ~u@@O                
#              /@@@@Mv`       ru@@@@O                
#              `~$Q@@@BNNNNNNN@@@@Q;'                
#                 `ZM@@@@@@@@@@@Zr                   
#                   .;;;;;;;;;;:                     
#                                                    
#                                                    

#----------------------------------------------------------------------
# INIT
#----------------------------------------------------------------------
[ -f "$XDG_CONFIG_HOME/shell/alias" ] && source "$XDG_CONFIG_HOME/shell/alias"
[ -f "$XDG_CONFIG_HOME/shell/vars" ] && source "$XDG_CONFIG_HOME/shell/vars"


#----------------------------------------------------------------------
# ZSH COMPLETION
#----------------------------------------------------------------------
## Load Modules
zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors

## Completion options
zstyle ':completion:' menu no # force zsh not to show the menu (for fzf-tab)
zstyle ':completion:' special-dirs true # Force . and .. to show
zstyle ':completion:' list-colors ${(s.:.)LS_COLORS} ma=0\;33
zstyle ':completion:' squeeze-slashes false # allow /*/ expansion
zstyle ':completion:*:git-checkout:*' sort false # no sort with git checkout
zstyle ':completion:*:descriptions' format '[%d]' # descriptions for group support
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # colorize filenames
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup


#----------------------------------------------------------------------
# GENERAL
#----------------------------------------------------------------------
## MAIN OPTS
setopt auto_menu menu_complete # autocmp first menu match
setopt autocd # type dir to cd
setopt auto_param_slash # when a dir is completed add a / instead of white space
setopt no_case_glob no_case_match # completion case insensitive
setopt globdots # include dotfiles
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell
unsetopt prompt_sp # dont autoclean blank lines
stty stop undef # disable accidental ctrl s

## HISTORY
setopt append_history share_history # better history
# on exit, history appends rather than overwrites; history is appended as soon as cmds executed; history shared across sessions
setopt hist_ignore_all_dups # ignore duplicate entries
setopt hist_reduce_blanks # strip extra blanks

HISTFILE="$XDG_CACHE_HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
HISTCONTROL=ignoreboth # consecutive duplicates & commands starting with space are not saved


## OTHER
autoload -U tetris # tetris in zsh !!


## open fff file manager with ctrl f
openfff() {
  fff <$TTY
  zle redisplay
}
zle -N openfff


#----------------------------------------------------------------------
# Load
#----------------------------------------------------------------------

# Source Host Specific Settings
source $ZDOTDIR/os-specific.sh

# Load fzf
source <(fzf --zsh)

# Load Starship
eval "$(starship init zsh)"
echo "$(cat $HOME/.config/zsh/banner)" | lolcat

# Load Pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init - zsh)"

# Load NVM
#export NVM_DIR="$HOME/.config/nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#export NVM_DIR="$HOME/.nvm"
#[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#. "$HOME/.local/share/../bin/env"

# SSH AGENT
source "$ZDOTDIR/ssh-agent"
ssh-cert

# Generated for envman. Do not edit.
#[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# Load Pywal Colours
(cat ~/.cache/wal/sequences &)


#----------------------------------------------------------------------
# BINDS
#----------------------------------------------------------------------
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line
bindkey "^j" backward-word
bindkey "^k" forward-word
bindkey "^H" backward-kill-word
# ctrl J & K for going up and down in prev commands
bindkey "^J" history-search-forward
bindkey "^K" history-search-backward
bindkey '^R' fzf-history-widget

bindkey '^f' openfff


#----------------------------------------------------------------------
# PLUGINS
#----------------------------------------------------------------------
# autosuggestions
# requires zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax highlighting
# requires zsh-syntax-highlighting package
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-completions
# requires https://github.com/zsh-users/zsh-completions
source /usr/share/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh

# fzf-tab
# requires https://github.com/Aloxaf/fzf-tab
source /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
