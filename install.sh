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
opt_install_jenv=2

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
    --[no-]install-jenv     Enable/disable the installation jenv
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
        --install-jenv)        opt_install_jenv=1     ;;
        --no-install-jenv)     opt_install_jenv=0     ;;
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
    ABS_PATH=${3-}
    TARGET_PREFIX=${HOME}/
    TARGET_PATH_FULL=${HOME}/${TARGET_PATH}
    ORIGIN_FULLPATH=${CURR_PATH}/${ORIGIN_NAME}
    if [ "$ABS_PATH" = "true" ]; then
        ORIGIN_PATH=${ORIGIN_FULLPATH}
    else
        ORIGIN_PATH=${ORIGIN_FULLPATH#${TARGET_PREFIX}}
    fi
    echo -n "link ${TARGET_PATH_FULL} to ${ORIGIN_PATH}... "
    TARGET_DIR=$(dirname ${TARGET_PATH_FULL})
    if [ ! -e "${TARGET_DIR}" ]; then
        mkdir -p "${TARGET_DIR}"
    fi
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

# Link dotfiles
echo -n "Create link for [dotfiles] "
sd_ask_var $opt_dotfiles "Do you want to link dotfiles?"
opt_dotfiles=$?
if [ $opt_dotfiles -eq 1 ]; then
    sd_create_link zshrc .zshrc
    sd_create_link zshenv .zshenv
    sd_create_link tmux.conf .tmux.conf
    sd_create_link gitconfig .gitconfig
    sd_create_link gitignore .gitignore
    sd_create_link globalrc .globalrc
    sd_create_link latexmkrc .latexmkrc
    sd_create_link vim .vim
    sd_create_link editorconfig .editorconfig
else
    echo "    ~ Skipped"
fi

echo
echo -n "Install [fzf] "
if [ ! -d "${HOME}/.fzf" ]; then
    sd_ask_var $opt_install_fzf "Do you want to install fzf?"
    opt_install_fzf=$?
    if [ $opt_install_fzf -eq 1 ]; then
        (
            git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.fzf
        ) && bash ~/.fzf/install --key-bindings --completion --no-update-rc
    else
        echo "    ~ Skipped"
    fi
else
    echo "    - Already exists"
fi

echo
echo -n "Install [nvm] "
export NVM_DIR="${HOME}/.nvm"
if [ ! -d "${NVM_DIR}" ]; then
    sd_ask_var $opt_install_nvm "Do you want to install nvm?"
    opt_install_nvm=$?
    if [ $opt_install_nvm -eq 1 ]; then
        (
            git clone --depth 1 https://github.com/creationix/nvm.git "$NVM_DIR"
            cd "$NVM_DIR"
            git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
        ) && \. "$NVM_DIR/nvm.sh"
        # Install default lts
        nvm install --lts=Gallium
        nvm alias default node
    else
        echo "    ~ Skipped"
    fi
else
    echo "    - Already exists"
fi

echo
echo -n "Install [gvm] "
if [ ! -d "${HOME}/.gvm" ]; then
    sd_ask_var $opt_install_gvm "Do you want to install gvm?"
    opt_install_gvm=$?
    if [ $opt_install_gvm -eq 1 ]; then
        bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
    else
        echo "    ~ Skipped"
    fi
else
    echo "    - Already exists"
fi

echo
echo -n "Install [pyenv] "
if [ ! -d "${HOME}/.pyenv" ]; then
    sd_ask_var $opt_install_pyenv "Do you want to install pyenv?"
    opt_install_pyenv=$?
    if [ $opt_install_pyenv -eq 1 ]; then
        (
            git clone --depth 1 https://github.com/pyenv/pyenv.git ${HOME}/.pyenv
        ) && (
            git clone --depth 1 https://github.com/pyenv/pyenv-virtualenv.git ${HOME}/.pyenv/plugins/pyenv-virtualenv
        )
    else
        echo "    ~ Skipped"
    fi
else
    echo "    - Already exists"
fi

echo
echo -n "Install [plenv] "
if [ ! -d "${HOME}/.plenv" ]; then
    sd_ask_var $opt_install_plenv "Do you want to install plenv?"
    opt_install_plenv=$?
    if [ $opt_install_plenv -eq 1 ]; then
        git clone --depth 1 https://github.com/tokuhirom/plenv.git ~/.plenv
    else
        echo "    ~ Skipped"
    fi
else
    echo "    - Already exists"
fi

echo
echo -n "Install [jenv] "
if [ ! -d "${HOME}/.jenv" ]; then
    sd_ask_var $opt_install_jenv "Do you want to install jenv?"
    opt_install_jenv=$?
    if [ $opt_install_jenv -eq 1 ]; then
        git clone --depth 1 https://github.com/jenv/jenv.git ~/.jenv
    else
        echo "    ~ Skipped"
    fi
else
    echo "    - Already exists"
fi
