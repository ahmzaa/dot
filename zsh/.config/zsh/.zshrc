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
[ -f "$XDG_CONFIG_HOME/shell/path" ] && source "$XDG_CONFIG_HOME/shell/path"


#----------------------------------------------------------------------
# ZSH COMPLETION
#----------------------------------------------------------------------
## Load Modules
zmodload zsh/complist
[ -d "$HOME/.zsh/plugins/zsh-completions/src" ] && fpath+="$HOME/.zsh/plugins/zsh-completions/src"
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
setopt hist_ignore_space # commands starting with a space are not saved
setopt hist_reduce_blanks # strip extra blanks

HISTFILE="$HOME/.config/zsh/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

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

# SSH agent
source "$ZDOTDIR/ssh-agent"

# SSH certificate check/renewal
"$ZDOTDIR/ssh-cert"

# Load fzf
source <(fzf --zsh)

# Load Starship
eval "$(starship init zsh)"
echo "$(cat $HOME/.config/zsh/banner)" | lolcat # | tte highlight


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
# Check if the plugin Dir exists
if [ ! -d "$HOME/.zsh/plugins" ]; then
  mkdir -p $HOME/.zsh/plugins
fi

# autosuggestions
# requires zsh-autosuggestions
if [ -f "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source $HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
else
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/plugins/zsh-autosuggestions
fi

# zsh-completions (added to $fpath before compinit above; clone if missing)
# requires https://github.com/zsh-users/zsh-completions
if [ ! -d "$HOME/.zsh/plugins/zsh-completions" ]; then
  git clone https://github.com/zsh-users/zsh-completions.git $HOME/.zsh/plugins/zsh-completions
fi

# fzf-tab
# requires https://github.com/Aloxaf/fzf-tab
if [ -f "$HOME/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh" ]; then
  source $HOME/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
else
  git clone https://github.com/Aloxaf/fzf-tab $HOME/.zsh/plugins/fzf-tab
fi

# syntax highlighting — MUST be sourced last (it wraps all existing widgets)
# requires zsh-syntax-highlighting package
if [ -f "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/plugins/zsh-syntax-highlighting
fi
