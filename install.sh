#!/usr/bin/env bash

set -u

version=0.0.1
opt_dotfiles=2
opt_install_fzf=1
opt_install_nvm=2
opt_install_gvm=2
opt_install_autoenv=2

shells="bash zsh fish"
prefix='~/.fzf'
prefix_expand=~/.fzf
fish_dir=${XDG_CONFIG_HOME:-$HOME/.config}/fish

help() {
    cat << EOF
usage: $0 [OPTIONS]

    --help                  Show this message
    --all                   Create link for dotfiles
                            Install all thing include fzf,nvm.gvm.autoenv

    --[no-]dot-files        Enable/disable link dotfiles
    --[no-]install-fzf      Enable/disable the installation fzf
    --[no-]install-nvm      Enable/disable the installation nvm
    --[no-]install-gvm      Enable/disable the installation gvm
    --[no-]install-autoenv  Enable/disable the installation autoenv
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
            opt_install_gvm=1
            opt_install_autoenv=1
            ;;
        --dot-files)           opt_dotfiles=1         ;;
        --no-dot-files)        opt_dotfiles=0         ;;
        --install-fzf)         opt_install_fzf=1      ;;
        --no-install-fzf)      opt_install_fzf=0      ;;
        --install-nvm)         opt_install_nvm=1      ;;
        --no-install-nvm)      opt_install_nvm=0      ;;
        --install-gvm)         opt_install_gvm=1      ;;
        --no-install-gvm)      opt_install_gvm=0      ;;
        --install-autoenv)     opt_install_autoenv=1  ;;
        --no-install-autoenv)  opt_install_autoenv=0  ;;
        *)
            echo "unknown option: $opt"
            help
            exit 1
            ;;
    esac
done

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

function sd_create_link() {
    ORIGIN_PATH=$1
    TARGET_PATH=$2
    TARGET_PREFIX=$HOME
    echo -n "link ${TARGET_PREFIX}/${TARGET_PATH} to ${ORIGIN_PATH}..."
    if [ ! -e "${TARGET_PREFIX}/${TARGET_PATH}" ]; then
        ln -s ${CURR_PATH}/${ORIGIN_PATH} ${TARGET_PREFIX}/${TARGET_PATH}
        echo "+ Added"
    else
        echo "- Already exists"
    fi
}

cd "$(dirname "${BASH_SOURCE[0]}")"
CURR_PATH=$(pwd)
# CURR_PATH=$(cd `dirname $0`; pwd)

if [ $opt_dotfiles -eq 2 ]; then
    echo
    sd_ask "Do you want to link dotfiles?"
    opt_dotfiles=$?
fi

# Link dotfiles
echo "Create link for dotfiles ..."
if [ $opt_dotfiles -eq 1 ]; then
    sd_create_link zshrc .zshrc
    sd_create_link zshenv .zshenv
    sd_create_link tmux.conf .tmux.conf
    sd_create_link spacemacs .spacemacs
    sd_create_link gitconfig .gitconfig
    sd_create_link globalrc .globalrc

    sd_create_link vim .vim
    sd_create_link editorconfig .editorconfig
else
    echo "    ~ Skipped"
fi

# Install fzf
if [ $opt_install_fzf -eq 2 ]; then
    echo
    sd_ask "Do you want to install fzf?"
    opt_install_fzf=$?
fi
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
if [ $opt_install_nvm -eq 2 ]; then
    echo
    sd_ask "Do you want to install nvm?"
    opt_install_nvm=$?
fi
if [ $opt_install_nvm -eq 1 ]; then
    echo "Install nvm ..."
    export NVM_DIR="${HOME}/.nvm"
    if [ ! -d "${NVM_DIR}" ]; then
        echo "Install nvm ..."
        (
            git clone https://github.com/creationix/nvm.git "$NVM_DIR"
            cd "$NVM_DIR"
            git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
        ) && \. "$NVM_DIR/nvm.sh"
        # Install default lts
        nvm install --lts=Carbon
    else
        echo "    - Already exists"
    fi
else
    echo "    ~ Skipped"
fi

# Install gvm
if [ $opt_install_gvm -eq 2 ]; then
    echo
    sd_ask "Do you want to install gvm?"
    opt_install_gvm=$?
fi
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

# Install autoenv
if [ $opt_install_autoenv -eq 2 ]; then
    echo
    sd_ask "Do you want to install autoenv?"
    opt_install_autoenv=$?
fi
if [ $opt_install_autoenv -eq 1 ]; then
    echo "Install autoenv ..."
    if [ ! -d "${HOME}/.autoenv" ]; then
        git clone git://github.com/kennethreitz/autoenv.git ${HOME}/.autoenv
    else
        echo "    - Already exists"
    fi
else
    echo "    ~ Skipped"
fi
