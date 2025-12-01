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

source "$ZDOTDIR/alias"
source "$ZDOTDIR/os-specific.sh"

# SSH AGENT
source "$ZDOTDIR/ssh-agent"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"


#----------------------------------------------------------------------
# Antidote Plugins - Lazy-load antidote conditionally gen static load file
#----------------------------------------------------------------------
zsh_plugins=${ZDOTDIR}/plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins} ]]; then
  (
    source $ZDOTDIR/.antidote/antidote.zsh
    antidote bundle <${zsh_plugins} >${zsh_plugins}.zsh
  )
fi
source ${zsh_plugins}.zsh


#----------------------------------------------------------------------
# Auto Complete
#----------------------------------------------------------------------
source $ZDOTDIR/completion.zsh


#----------------------------------------------------------------------
# History
#----------------------------------------------------------------------

# HISTORY
HISTFILE="$ZDOTDIR/.zsh_history"
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
# Load
#----------------------------------------------------------------------

# Load Starship
eval "$(starship init zsh)"
echo "$(cat $HOME/.config/zsh/banner)" | lolcat

# Load Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# Load NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm, without auto-using the default version
