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

# golang version manager configuration
# Check if the alias 'g' exists before trying to unalias it
if [[ -n $(alias g 2>/dev/null) ]]; then
	unalias g
fi
[ -s "${HOME}/.g/env" ] && \. "${HOME}/.g/env" # g shell setup

# direnv configuration
direnv > /dev/null 2>&1 && eval "$(direnv hook zsh)"


fgd() {
    preview="git diff $@ --color=always -- {-1}"
    git diff $@ --name-only | fzf -m --ansi --preview $preview
}

export GPG_TTY=$(tty)
export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent:$(gpgconf --list-dirs agent-extra-socket):1"

grep -qi microsoft /proc/version 2>/dev/null && [[ -f ~/.dotfiles/wsl/proxy.sh ]] && source ~/.dotfiles/wsl/proxy.sh
