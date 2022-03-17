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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#install:
#     proxychains curl -s "https://get.sdkman.io" > sdkman
#     proxychains bash sdkman
export SDKMAN_DIR="/home/sunday/.sdkman"
[[ -s "/home/sunday/.sdkman/bin/sdkman-init.sh" ]] && source "/home/sunday/.sdkman/bin/sdkman-init.sh"

# direnv configuration
direnv > /dev/null 2>&1 && eval "$(direnv hook zsh)"

# alias
# alias ping='prettyping --nolegend'
alias emacs-prelude='emacs -q -l ~/.emacs.d-prelude/init.el'
alias emacs-mytest='emacs -q -l ~/.emacs.d-mytest/init.el'

fd() {
    preview="git diff $@ --color=always -- {-1}"
    git diff $@ --name-only | fzf -m --ansi --preview $preview
}
