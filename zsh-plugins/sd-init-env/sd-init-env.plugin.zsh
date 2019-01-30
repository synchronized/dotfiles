#!/bin/zsh

# nvm configuration
# This loads nvm
[[ -s "${HOME}/.nvm/nvm.sh" ]] && source "${HOME}/.nvm/nvm.sh"

# gvm configuration
[[ -s "${HOME}/.gvm/scripts/gvm" ]] && source "${HOME}/.gvm/scripts/gvm"

# rvm configuration
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# fzf configuration
[[ -s "${HOME}/.fzf.zsh" ]] && source "${HOME}/.fzf.zsh"

# autoenv configuration
[[ -s "${HOME}/.autoenv/activate.sh" ]] && source "${HOME}/.autoenv/activate.sh"


# alias
# alias ping='prettyping --nolegend'
alias emacs-prelude='emacs -q -l ~/.emacs.d-prelude/init.el'
