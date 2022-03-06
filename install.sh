#!/usr/bin/env bash

set -u

version=0.0.1
# Installaion default mode
#   0: not install
#   1: install
#   2: ask before install
opt_dotfiles=2
opt_install_fzf=1
opt_install_nvm=2
opt_install_nvm_pkg=2
opt_install_gvm=2
opt_install_pyenv=2
opt_install_plenv=0

help() {
    cat << EOF
usage: $0 [OPTIONS]

    --help                  Show this message
    --all                   Create link for dotfiles
                            Install all thing include fzf,nvm.gvm.autoenv

    --[no-]dot-files        Enable/disable link dotfiles
    --[no-]install-fzf      Enable/disable the installation fzf
    --[no-]install-nvm      Enable/disable the installation nvm
    --[no-]install-nvm-pkg  Enable/disable the installation nvm packages
                            js-beautify, eslint, tern, vmd
    --[no-]install-gvm      Enable/disable the installation gvm
    --[no-]install-pyenv    Enable/disable the installation pyenv
    --[no-]install-plenv    Enable/disable the installation plenv
EOF
}

for opt in "$@"; do
    case $opt in
        --help)
            help
            exit 0
            ;;
        --all)
            opt_dotfiles=1
            opt_install_fzf=1
            opt_install_nvm=1
            opt_install_nvm_pkg=1
            opt_install_gvm=1
            opt_install_pyenv=1
            ;;
        --dot-files)           opt_dotfiles=1         ;;
        --no-dot-files)        opt_dotfiles=0         ;;
        --install-fzf)         opt_install_fzf=1      ;;
        --no-install-fzf)      opt_install_fzf=0      ;;
        --install-nvm)         opt_install_nvm=1      ;;
        --no-install-nvm)      opt_install_nvm=0      ;;
        --install-nvm-pkg)     opt_install_nvm_pkg=1  ;;
        --no-install-nvm-pkg)  opt_install_nvm_pkg=0  ;;
        --install-gvm)         opt_install_gvm=1      ;;
        --no-install-gvm)      opt_install_gvm=0      ;;
        --install-pyenv)       opt_install_pyenv=1    ;;
        --no-install-pyenv)    opt_install_pyenv=0    ;;
        --install-plenv)       opt_install_plenv=1    ;;
        --no-install-plenv)    opt_install_plenv=0    ;;
        *)
            echo "unknown option: $opt"
            help
            exit 1
            ;;
    esac
done

# @param string msg($1)   when query user show message
sd_ask() {
    while true; do
        read -p "$1 ([y]/n) " -r
        REPLY=${REPLY:-"y"}
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            return 1
        elif [[ $REPLY =~ ^[Nn]$ ]]; then
            return 0
        fi
    done
}

# @param string var($1)   current flag value
# @param string msg($2)   when query user show message
function sd_ask_var() {
    local tmp_flag=$1
    local tmp_msg="$2"
    if [ $tmp_flag -eq 2 ]; then
        echo
        sd_ask "$tmp_msg"
        tmp_flag=$?
    fi
    return $tmp_flag
}

function sd_create_link() {
    ORIGIN_NAME=$1
    TARGET_PATH=$2
    TARGET_PREFIX=${HOME}/
    TARGET_PATH_FULL=${HOME}/${TARGET_PATH}
    ORIGIN_FULLPATH=${CURR_PATH}/${ORIGIN_NAME}
    ORIGIN_PATH=${ORIGIN_FULLPATH#${TARGET_PREFIX}}
    echo -n "link ${TARGET_PATH_FULL} to ${ORIGIN_PATH}... "
    if [ ! -e "${TARGET_PATH_FULL}" ]; then
        ln -s ${ORIGIN_PATH} ${TARGET_PATH_FULL}
        echo "+ Added"
    else
        echo "- Already exists"
    fi
}

function sd_copy_file() {
    ORIGIN_PATH=$1
    TARGET_PATH_FULL=$2
    echo -n "copy ${ORIGIN_PATH} to ${TARGET_PATH_FULL}... "
    if [ ! -e "${TARGET_PATH_FULL}" ]; then
        cp ${ORIGIN_PATH} ${TARGET_PATH_FULL}
        echo "+ Added"
    else
        echo "- Already exists"
    fi
}

cd "$(dirname "${BASH_SOURCE[0]}")"
CURR_PATH=$(pwd)
# CURR_PATH=$(cd `dirname $0`; pwd)

# Install dotfiles
sd_ask_var $opt_dotfiles "Do you want to link dotfiles?"
opt_dotfiles=$?

# Link dotfiles
echo "Create link for dotfiles ..."
if [ $opt_dotfiles -eq 1 ]; then
    sd_create_link zshrc .zshrc
    sd_create_link zshenv .zshenv
    sd_create_link tmux.conf .tmux.conf
    sd_create_link gitconfig .gitconfig
    sd_create_link globalrc .globalrc
    sd_create_link latexmkrc .latexmkrc

    sd_create_link vim .vim
    sd_create_link editorconfig .editorconfig

    sd_copy_file spacemacs ${HOME}/.spacemacs
else
    echo "    ~ Skipped"
fi

# Install fzf
sd_ask_var $opt_install_fzf "Do you want to install fzf?"
opt_install_fzf=$?
if [ $opt_install_fzf -eq 1 ]; then
    echo "Install fzf ..."
    if [ ! -d "${HOME}/.fzf" ]; then
        echo "Install junegunn/fzf ..."
        git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.fzf
        bash ~/.fzf/install --key-bindings --completion --no-update-rc
        echo "    + Added"
    else
        echo "    - Already exists"
    fi
else
    echo "    ~ Skipped"
fi

# Install nvm
sd_ask_var $opt_install_nvm "Do you want to install nvm?"
opt_install_nvm=$?
if [ $opt_install_nvm -eq 1 ]; then
    echo "Install nvm ..."
    export NVM_DIR="${HOME}/.nvm"
    if [ ! -d "${NVM_DIR}" ]; then
        echo "Install nvm ..."
        (
            git clone --depth 1 https://github.com/creationix/nvm.git "$NVM_DIR"
            cd "$NVM_DIR"
            git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
        ) && \. "$NVM_DIR/nvm.sh"
        # Install default lts
        nvm install --lts=gallium
        nvm alias default node
    else
        echo "    - Already exists"
    fi
else
    echo "    ~ Skipped"
fi

# Install nvm-pkg
sd_ask_var $opt_install_nvm_pkg "Do you want to install nvm-pkg(js-beautify eslint tern vmd)?"
opt_install_nvm_pkg=$?
if [ $opt_install_nvm_pkg -eq 1 ]; then
    echo "Install nvm-pkg(js-beautify eslint tern vmd) ..."
    export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
    npm install -g js-beautify eslint tern vmd
else
    echo "    ~ Skipped"
fi

# Install gvm
sd_ask_var $opt_install_gvm "Do you want to install gvm?"
opt_install_gvm=$?
if [ $opt_install_gvm -eq 1 ]; then
    echo "Install gvm ..."
    if [ ! -d "${HOME}/.gvm" ]; then
        bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
    else
        echo "    - Already exists"
    fi
else
    echo "    ~ Skipped"
fi

# Install pyenv
sd_ask_var $opt_install_pyenv "Do you want to install pyenv?"
opt_install_pyenv=$?
if [ $opt_install_pyenv -eq 1 ]; then
    echo "Install pyenv ..."
    if [ ! -d "${HOME}/.pyenv" ]; then
        git clone https://github.com/pyenv/pyenv.git ${HOME}/.pyenv
        git clone https://github.com/pyenv/pyenv-virtualenv.git ${HOME}/.pyenv/plugins/pyenv-virtualenv
    else
        echo "    - Already exists"
    fi
else
    echo "    ~ Skipped"
fi
