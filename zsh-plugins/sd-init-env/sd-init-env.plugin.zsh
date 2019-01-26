#!/bin/zsh

# nvm configuration
[ -s "${HOME}/.nvm/nvm.sh" ] && source "${HOME}/.nvm/nvm.sh" # This loads nvm

# gvm configuration
[[ -s "${HOME}/.gvm/scripts/gvm" ]] && source "${HOME}/.gvm/scripts/gvm"

# rvm configuration
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# fzf configuration
[[ -f "${HOME}/.fzf.zsh" ]] && source "${HOME}/.fzf.zsh"

# autoenv configuration
AUTOENV_ENABLE_LEAVE=ON
[[ -f "${HOME}/.autoenv/activate.sh" ]] && source "${HOME}/.autoenv/activate.sh"

# alias ping='prettyping --nolegend'
