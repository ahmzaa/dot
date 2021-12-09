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
setopt autocd extendedglob nomatch
unsetopt beep notify
bindkey -v

# ALIAS
[ -f "$HOME/.zsh/aliases" ] && source "$HOME/.zsh/aliases"

# AUTOJUMP
[[ -s /home/ahmza/.autojump/etc/profile.d/autojump.sh ]] && source /home/ahmza/.autojump/etc/profile.d/autojump.sh

# PATH EXPORTS
export PATH="/home/ahmza/bin:$PATH"
export PATH="/home/ahmza/.local/bin:$PATH"

# ANTIGEN PLUGINS
# Load plugin changes by running
# antibody bundle < ~/.zsh_plugins > ~/.zsh_plugins.sh
source ~/.zsh_plugins.sh


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
# Theme
#----------------------------------------------------------------------

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_PROMPT_ADD_NEWLINE=false
# SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "

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
