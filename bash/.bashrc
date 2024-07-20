# ⚡
PS1='\[\e[1;32m\]➜\[\e[0m\] \[\e[1;36m\]\W\[\e[0m\]\[\e[1;31m\]$(__git_ps1)\[\e[0m\] \[\e[1;33m\]✗\[\e[0m\] '


if command -v oh-my-posh &>/dev/null; then
    eval "$(oh-my-posh --init --shell bash --config ~/.config/themes/jay.omp.json)"
fi



# Basic alias 
alias open='explorer.exe'	# for Windows or WSL
alias cd..='cd ..'
alias cls='clear'


# Include user's utilities
. ~/.config/bash/utilities/alias.sh
. ~/.config/bash/utilities/z.sh
alias cdd=". ~/.config/bash/utilities/cdd.sh"


# Pro alias
if command -v exa &>/dev/null; then
    alias l='exa -abghHliS'
    alias la='exa -l'
    alias ll='exa -la -g --icons'
    alias lt='exa -l --tree --icons'
fi

if command -v nvim &>/dev/null; then
    alias vim='nvim'
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi


export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
