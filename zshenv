#!/bin/zsh

export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8
export LD_LIBRARY_PATH="/usr/local/lib:${LD_LIBRARY_PATH}"
export EDITOR=vim
export GTAGSLABEL=pygments

# perl configuration, now use plenv
# PERL5_LOCAL_HOME="${HOME}/perl5"
# export PATH="${PERL5_LOCAL_HOME}/bin${PATH:+:${PATH}}"
# export PERL5LIB="${PERL5_LOCAL_HOME}/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
# export PERL_LOCAL_LIB_ROOT="${PERL5_LOCAL_HOME}${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
# export PERL_MB_OPT="--install_base \"${PERL5_LOCAL_HOME}\""
# export PERL_MM_OPT="INSTALL_BASE=${PERL5_LOCAL_HOME}"

# pyenv configuration
[[ -d "${HOME}/.pyenv/bin" ]] && export PATH="${HOME}/.pyenv/bin:$PATH"

# plenv configuration
[[ -d "${HOME}/.plenv/bin" ]] && export PATH="${HOME}/.plenv/bin:$PATH"

# load local zshenv file
[[ -f "${HOME}/.zshenv.local" ]] && . "${HOME}/.zshenv.local"
