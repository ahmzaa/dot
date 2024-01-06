# AHMZA's ZSHRC configuration

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
# General
#----------------------------------------------------------------------
zmodload zsh/zprof

setopt autocd extendedglob nomatch
unsetopt beep notify
bindkey -v

source "$HOME/.config/zsh/alias"
source "$HOME/.config/zsh/exports"
source "$HOME/.config/zsh/specific"

# ANTIGEN PLUGINS
# Load plugin changes by running
# antibody bundle < ~/.config/zsh/plugins > ~/.zsh_plugins
source "$HOME/.zsh_plugins"

# SSH AGENT
source "$HOME/.config/zsh/ssh-agent"


#----------------------------------------------------------------------
# Auto Complete
#----------------------------------------------------------------------
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

zmodload -i zsh/complist

setopt auto_list
setopt auto_menu
setopt always_to_end
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:::::' completer _expand _complete _ignored _approximate

#----------------------------------------------------------------------
# History
#----------------------------------------------------------------------

# HISTORY
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history

# HIST SUBSTR SEARCH
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


#----------------------------------------------------------------------
# Load Starship
#----------------------------------------------------------------------

eval "$(starship init zsh)"

echo "$(cat $HOME/.config/zsh/banner)" | lolcat
