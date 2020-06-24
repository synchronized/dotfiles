#!/bin/zsh

# nvm configuration
# This loads nvm
[[ -s "${HOME}/.nvm/nvm.sh" ]] && source "${HOME}/.nvm/nvm.sh"

# gvm configuration
[[ -s "${HOME}/.gvm/scripts/gvm" ]] && source "${HOME}/.gvm/scripts/gvm"

# fzf configuration
[[ -s "${HOME}/.fzf.zsh" ]] && source "${HOME}/.fzf.zsh"

# alias
# alias ping='prettyping --nolegend'
alias emacs-prelude='emacs -q -l ~/.emacs.d-prelude/init.el'
alias emacs-mytest='emacs -q -l ~/.emacs.d-mytest/init.el'
