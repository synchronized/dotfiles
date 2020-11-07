#!/bin/zsh

# nvm configuration
# This loads nvm
[[ -s "${HOME}/.nvm/nvm.sh" ]] && source "${HOME}/.nvm/nvm.sh"

# gvm configuration
[[ -s "${HOME}/.gvm/scripts/gvm" ]] && source "${HOME}/.gvm/scripts/gvm"

# fzf configuration
[[ -s "${HOME}/.fzf.zsh" ]] && source "${HOME}/.fzf.zsh"

# pyenv configuration
[[ -d "${HOME}/.pyenv/bin" ]] && eval "$(pyenv init -)"
[[ -d "${HOME}/.pyenv/bin" ]] && eval "$(pyenv virtualenv-init -)"

# plenv configuration
[[ -d "${HOME}/.plenv/bin" ]] && eval "$(plenv init -)"

# direnv configuration
direnv > /dev/null 2>&1 && eval "$(direnv hook zsh)"

# alias
# alias ping='prettyping --nolegend'
alias emacs-prelude='emacs -q -l ~/.emacs.d-prelude/init.el'
alias emacs-mytest='emacs -q -l ~/.emacs.d-mytest/init.el'
