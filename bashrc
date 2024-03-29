#
# 将下面的命令加入"${HOME}/.bashrc"
#
# [[ -f "${HOME}/.dotfiles/bashrc" ]] && . "${HOME}/.dotfiles/bashrc"
#

. "${HOME}/.dotfiles/zshfunc"
if sd_not_exist $PATH "${HOME}/.local/bin"; then
  [[ -d "${HOME}/.local/bin" ]] && export PATH="${HOME}/.local/bin:$PATH"
fi

# git-fuzzy configuration
[[ -f "${HOME}/.dotfiles/git-fuzzy/bin/git-fuzzy" ]] && export PATH="${HOME}/.dotfiles/git-fuzzy/bin:$PATH"

# pyenv configuration
[[ -d "${HOME}/.pyenv/bin" ]] && export PATH="${HOME}/.pyenv/bin:$PATH"
[[ -d "${HOME}/.pyenv/shims" ]] && export PATH="${HOME}/.pyenv/shims:$PATH"

# plenv configuration
[[ -d "${HOME}/.plenv/bin" ]] && export PATH="${HOME}/.plenv/bin:$PATH"

# jenv configuration
[[ -d "${HOME}/.jenv/bin" ]] && export PATH="$HOME/.jenv/bin:$PATH"


######################################################################
# nvm configuration
[[ -s "${HOME}/.nvm/nvm.sh" ]] && source "${HOME}/.nvm/nvm.sh"

# gvm configuration
[[ -s "${HOME}/.gvm/scripts/gvm" ]] && source "${HOME}/.gvm/scripts/gvm"

# fzf configuration
[[ -s "${HOME}/.fzf.zsh" ]] && source "${HOME}/.fzf.bash"

# pyenv configuration
[[ -d "${HOME}/.pyenv/bin" ]] && eval "$(pyenv init -)"
[[ -d "${HOME}/.pyenv/bin" ]] && eval "$(pyenv virtualenv-init -)"

# plenv configuration
[[ -d "${HOME}/.plenv/bin" ]] && eval "$(plenv init -)"

# jenv configuration
[[ -d "${HOME}/.jenv/bin" ]] && eval "$(jenv init -)"

# z.lua configuration
[[ -d "${HOME}/.dotfiles/thirdpart/z.lua" ]] && eval "$(lua ${HOME}/.dotfiles/thirdpart/z.lua/z.lua --init zsh)"