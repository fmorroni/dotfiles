export STARSHIP_CONFIG="$XDG_CONFIG_HOME/zsh/starship.toml"

export PNPM_HOME="$HOME/.local/share/pnpm"

export ANDROID_HOME="$HOME/lib/android/sdk"
export ANDROID_SDK_HOME="$ANDROID_HOME"
export ANDROID_AVD_HOME="$ANDROID_SDK_HOME/avd"
export ANDROID_TOOLS_PATHS="$ANDROID_SDK_HOME/cmdline-tools/latest/bin"

fpath+="$XDG_CONFIG_HOME/zsh/completions"

export EDITOR=nvim
export ZK_NOTEBOOK_DIR="$HOME/Documents/zk-notebook/"
export SCREEN_RECS="$HOME/Videos"
export MNT_DIR="$HOME/mnt/"

# For use in psql
export PAGER="less -S"
