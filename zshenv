#!/bin/zsh

export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8
export LD_LIBRARY_PATH="/usr/local/lib:${LD_LIBRARY_PATH}"
export EDITOR=vim
export GTAGSLABEL=pygments

# perl configuration
PERL5_LOCAL_HOME="${HOME}/perl5"
export PATH="${PERL5_LOCAL_HOME}/bin${PATH:+:${PATH}}"
export PERL5LIB="${PERL5_LOCAL_HOME}/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="${PERL5_LOCAL_HOME}${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"${PERL5_LOCAL_HOME}\""
export PERL_MM_OPT="INSTALL_BASE=${PERL5_LOCAL_HOME}"

# autoenv enable leave
export AUTOENV_ENABLE_LEAVE=ON

# rvm configuration
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
[[ -d "$HOME/.rvm/bin" ]] && export PATH="${PATH}:${HOME}/.rvm/bin"

# load local zshenv file
[[ -f "${HOME}/.zshenv.local" ]] && . "${HOME}/.zshenv.local"
