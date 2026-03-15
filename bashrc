#
# 将下面的命令加入"${HOME}/.bashrc"
#
# [[ -f "${HOME}/.dotfiles/bashrc" ]] && . "${HOME}/.dotfiles/bashrc"
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'

. "${HOME}/.dotfiles/zshfunc"
if sd_not_exist $PATH "${HOME}/.local/bin"; then
  [[ -d "${HOME}/.local/bin" ]] && export PATH="${HOME}/.local/bin:$PATH"
fi

# fzf configuration
[[ -s "${HOME}/.fzf.zsh" ]] && source "${HOME}/.fzf.bash"

# nvm configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_compl

# pyenv configuration
[[ -d "${HOME}/.pyenv/bin" ]] && export PATH="${HOME}/.pyenv/bin:$PATH"
[[ -d "${HOME}/.pyenv/shims" ]] && export PATH="${HOME}/.pyenv/shims:$PATH"
#[[ -d "${HOME}/.pyenv/bin" ]] && eval "$(pyenv virtualenv-init -)"


export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node/
export LC_ALL=en_US.UTF-8
export http_proxy=http://127.0.0.1:7890
export https_proxy=http://127.0.0.1:7890

