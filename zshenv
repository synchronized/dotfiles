#!/bin/zsh

export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8
export LD_LIBRARY_PATH="/usr/local/lib:${LD_LIBRARY_PATH}"
export EDITOR=vim
export GTAGSLABEL=pygments

. "${HOME}/.dotfiles/zshfunc"

# perl configuration, now use plenv
# PERL5_LOCAL_HOME="${HOME}/perl5"
# export PATH="${PERL5_LOCAL_HOME}/bin${PATH:+:${PATH}}"
# export PERL5LIB="${PERL5_LOCAL_HOME}/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
# export PERL_LOCAL_LIB_ROOT="${PERL5_LOCAL_HOME}${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
# export PERL_MB_OPT="--install_base \"${PERL5_LOCAL_HOME}\""
# export PERL_MM_OPT="INSTALL_BASE=${PERL5_LOCAL_HOME}"
#
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

# doom emacs configuration
[[ -d "${HOME}/.config/emacs/bin" ]] && export PATH="${HOME}/.config/emacs/bin:$PATH"

# load local zshenv file
[[ -f "${HOME}/.zshenv.local" ]] && . "${HOME}/.zshenv.local"

export GPG_TTY=$(tty)
export GPG_AGENT_INFO=`gpgconf --list-dirs agent-socket | tr -d '\n' && echo -n ::`
