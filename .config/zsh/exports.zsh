export STARSHIP_CONFIG="$XDG_CONFIG_HOME/zsh/starship.toml"
export PNPM_HOME="$HOME/.local/share/pnpm"
# export PATH="$(pnpm root -g)/.bin:$PATH"
export PATH="$PNPM_HOME:$HOME/.cargo/bin/:$HOME/scripts/bin:$PATH"
# export PATH="./:$PATH" # Works but no autocomplete
fpath+="$XDG_CONFIG_HOME/zsh/completions"

export MNT_DIR="$HOME/mnt/"
export ZK_NOTEBOOK_DIR="$HOME/Documents/zk-notebook/"
# For use in psql
export PAGER="less -S"
