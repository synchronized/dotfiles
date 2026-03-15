#!/bin/zsh

# fzf configuration
[[ -s "${HOME}/.fzf.zsh" ]] && source "${HOME}/.fzf.zsh"

# nvm configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_compl

# pyenv configuration
[[ -d "${HOME}/.pyenv/bin" ]] && eval "$(pyenv init -)"
[[ -d "${HOME}/.pyenv/bin" ]] && eval "$(pyenv virtualenv-init -)"

# direnv configuration
direnv > /dev/null 2>&1 && eval "$(direnv hook zsh)"

# alias
# alias ping='prettyping --nolegend'
alias emacs-prelude='emacs -q -l ~/.emacs.d-prelude/init.el'
alias emacs-mytest='emacs -q -l ~/.emacs.d-mytest/init.el'

fgd() {
    preview="git diff $@ --color=always -- {-1}"
    git diff $@ --name-only | fzf -m --ansi --preview $preview
}
