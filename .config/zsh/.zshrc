#!/bin/sh

[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# zsh-supercharged sets up this stuff
# history
# HISTFILE=$ZDOTDIR/.zsh_history
# HISTSIZE=1000
# SAVEHIST=1000
# setopt extendedglob nomatch append_history hist_ignore_all_dups

setopt PUSHDSILENT

# plugins
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "wintermi/zsh-starship"
plug "zap-zsh/fzf"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/vim"
# plug "jeffreytse/zsh-vi-mode"
# plug "hlissner/zsh-autopair"
# plug "zap-zsh/exa"

# source
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/functions.zsh"
plug "$HOME/.config/zsh/keybinds.zsh"
plug "$HOME/.config/zsh/directory_history.zsh"

# for comp_file in "$XDG_CONFIG_HOME"/zsh/completions/*; do
#   if [[ $(basename "$comp_file") == _* ]]; then
#       plug "$comp_file"
#   fi
# done

# if command -v bat &> /dev/null; then
#   alias cat="bat -pp --theme \"Visual Studio Dark+\"" 
#   alias catt="bat --theme \"Visual Studio Dark+\"" 
# fi

# Start ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# Syntax highlighting customization
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]='fg=#00c3ff'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#8f8d8d'
