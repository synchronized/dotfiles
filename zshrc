# fix: nice(5) failed: operation not permitted
ANTIGEN_PATH=~/.dotfiles
source $ANTIGEN_PATH/antigen/antigen.zsh
antigen init $ANTIGEN_PATH/antigenrc

[ -s ~/.luaver/luaver ] && . ~/.luaver/luaver

[[ -f "${HOME}/.zshrc.local" ]] && . "${HOME}/.zshrc.local"


