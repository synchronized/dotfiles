# fix: nice(5) failed: operation not permitted
if [[ "$SD_PLATFORM" == "WSL" ]]; then
    unsetopt BG_NICE
fi
ANTIGEN_PATH=~/.dotfiles
source $ANTIGEN_PATH/antigen/antigen.zsh
antigen init $ANTIGEN_PATH/antigenrc

[[ -f "${HOME}/.zshrc.local" ]] && . "${HOME}/.zshrc.local"
