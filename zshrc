ANTIGEN_PATH=~/.dotfiles
source $ANTIGEN_PATH/antigen/antigen.zsh
antigen init $ANTIGEN_PATH/antigenrc

[[ -f "${HOME}/.zshrc.local" ]] && . "${HOME}/.zshrc.local"
