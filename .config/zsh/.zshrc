#!/bin/sh

[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# This is so <c-s-z> and <c-s-x> work on kitty. Uggly but it works for now.
# See 'https://github.com/kovidgoyal/kitty/discussions/5296'
autoload -Uz -- /usr/lib64/kitty/shell-integration/zsh/kitty-integration; kitty-integration; unfunction kitty-integration

# Run this when some completions changed. Don't keep it activated
# because it slows down the startup.
# autoload -Uz compinit
# compinit

# Disable xon/xoff flow-control (without this c-s stops terminal output and c-q resumes it,
# there's probably a reason that exists but it's confusing and usless for me)
stty -ixon

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
# plug "$HOME/.config/zsh/exports.zsh" --> Replaced for .zshenv which is automatically sourced before zshrc
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

# TODO: remove. Using user service now.
#
# Start ssh-agent
# if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#     ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
# fi
# if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
#     source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
# fi

# Syntax highlighting customization
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]='fg=#00c3ff'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#8f8d8d'

eval "$(zoxide init zsh)"

# Ruby
source "/usr/share/chruby/chruby.sh"
RUBIES+=(
  $XDG_DATA_HOME/rubies/*(/)
)
