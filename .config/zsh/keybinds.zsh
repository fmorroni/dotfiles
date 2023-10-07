#!/bin/sh

bindkey -M vicmd '^ ' autosuggest-accept
bindkey -M viins '^ ' autosuggest-accept
bindkey -M vicmd '^O' fzf-history-widget #history-incremental-pattern-search-backward
bindkey -M viins '^O' fzf-history-widget #history-incremental-pattern-search-backward
# bindkey -M vicmd '^P' history-incremental-pattern-search-forward
# bindkey -M viins '^P' history-incremental-pattern-search-forward
# bindkey -M vicmd '^P' cdi_current_dir
# bindkey -M viins '^P' cdi_current_dir
bindkey -M vicmd '^P' open_directory_history
bindkey -M viins '^P' open_directory_history
bindkey -M viins '^K' up-history
bindkey -M viins '^J' down-history
bindkey -M vicmd '^K' up-history
bindkey -M vicmd '^J' down-history
bindkey -M vicmd 'y' vi-yank-xclip
bindkey -M vicmd 'Y' vi-yank-eol-xclip
bindkey -M vicmd '^R' redo
bindkey -M viins '^R' redo
