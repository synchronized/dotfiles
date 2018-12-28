#!/bin/bash

CURR_PATH=$(cd `dirname $0`; pwd)

function sd_install_link() {
    ORIGIN_PATH=$1
    TARGET_PATH=$2
    TARGET_PREFIX=$HOME
    if [ ! -e "${TARGET_PREFIX}/${TARGET_PATH}" ]
    then
        echo "link ${TARGET_PREFIX}/${TARGET_PATH} to ${CURR_PATH}/${ORIGIN_PATH}"
        ln -s ${CURR_PATH}/${ORIGIN_PATH} ${TARGET_PREFIX}/${TARGET_PATH}
    fi
}

sd_install_link zshrc .zshrc
sd_install_link zshenv .zshenv
sd_install_link tmux.conf .tmux.conf
sd_install_link spacemacs .spacemacs
sd_install_link gitconfig .gitconfig
sd_install_link globalrc .globalrc

sd_install_link vim .vim
sd_install_link editorconfig .editorconfig

#-----------------------------------------------------------------------------
# Install fzf
if [ ! -d "${HOME}/.fzf" ]
then
    echo "Install junegunn/fzf ..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.fzf
    bash ~/.fzf/install --key-bindings --completion --no-update-rc
fi

#-----------------------------------------------------------------------------
# Install nvm
export NVM_DIR="${HOME}/.nvm"
if [ ! -d "${NVM_DIR}" ]
then
    echo "Install nvm ..."
    (
        git clone https://github.com/creationix/nvm.git "$NVM_DIR"
        cd "$NVM_DIR"
        git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
    ) && \. "$NVM_DIR/nvm.sh"
    # Install default lts
    nvm install --lts=Carbon
fi
