#
# 将下面的命令加入"${HOME}/.bashrc"
#
# [[ -f "${HOME}/.dotfiles/bashrc" ]] && . "${HOME}/.dotfiles/bashrc"
#

. "${HOME}/.dotfiles/zshfunc"
if sd_not_exist $PATH "${HOME}/.local/bin"; then
  [[ -d "${HOME}/.local/bin" ]] && export PATH="${HOME}/.local/bin:$PATH"
fi

# fzf configuration
[[ -s "${HOME}/.fzf.zsh" ]] && source "${HOME}/.fzf.bash"

# pyenv configuration
[[ -d "${HOME}/.pyenv/bin" ]] && export PATH="${HOME}/.pyenv/bin:$PATH"
[[ -d "${HOME}/.pyenv/shims" ]] && export PATH="${HOME}/.pyenv/shims:$PATH"
#[[ -d "${HOME}/.pyenv/bin" ]] && eval "$(pyenv virtualenv-init -)"

# jenv configuration
[[ -d "${HOME}/.jenv/bin" ]] && export PATH="$HOME/.jenv/bin:$PATH"

# nvm configuration
[[ -s "${HOME}/.nvm/nvm.sh" ]] && source "${HOME}/.nvm/nvm.sh"

# gvm configuration
[[ -s "${HOME}/.gvm/scripts/gvm" ]] && source "${HOME}/.gvm/scripts/gvm"

# jenv configuration
[[ -d "${HOME}/.jenv/bin" ]] && eval "$(jenv init -)"
