# fix: nice(5) failed: operation not permitted

#set -o emacs
#export HISTFILE="~/.zsh_history"

DOT_ROOTPATH=~/.dotfiles

source ~/.dotfiles/thirdpart/zplug/init.zsh

zplug "robbyrussell/oh-my-zsh", as:plugin, use:"lib/*.zsh"


# Extra zsh completions
zplug "zsh-users/zsh-completions"

zplug "zsh-users/zsh-autosuggestions"

zplug "plugins/git",   from:oh-my-zsh
#zplug "modules/prompt", from:prezto

zplug "mrjohannchang/zsh-interactive-cd", defer:1
#zplug 'wfxr/forgit'
zplug "changyuheng/fz", defer:1
zplug "rupa/z", use:z.sh
zplug "bigH/git-fuzzy", as:command, use:"bin/git-fuzzy", depth:1

# Load theme file
zplug 'dracula/zsh', as:theme

# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Can manage local plugins
zplug "~/.zsh", from:local, defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
#zplug load --verbose
zplug load
