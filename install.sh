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
