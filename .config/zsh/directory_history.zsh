DIRECTORY_HISTORY=()
DIRHISTORY_SIZE=30

function push_dir() {
  setopt localoptions no_ksh_arrays
  if [[ -n $1 ]]; then
    dir=$(realpath $1 2>/dev/null);
    if [[ $? -ne 0 ]]; then
      echo "No such file or directory: $1" >&2
      return 1
    fi
  else
    dir=$HOME
  fi

  builtin cd $dir

  if [[ $? -ne 0 ]]; then
    return 1
  fi

  if [[ $#DIRECTORY_HISTORY -ge $DIRHISTORY_SIZE ]]; then
    shift DIRECTORY_HISTORY
  fi
  if [[ "$dir" != "$HOME" && ($#DIRECTORY_HISTORY -eq 0 || $DIRECTORY_HISTORY[$#DIRECTORY_HISTORY] != "$dir") ]]; then
    DIRECTORY_HISTORY+=($dir)
  fi
}
zle -N push_dir

function delete_history_dir() {
  setopt localoptions no_ksh_arrays
  local index=$1

  if [[ $index -ge 1 && $index -le $#DIRECTORY_HISTORY ]]; then

    for ((i = index; i <= $#DIRECTORY_HISTORY; i++)); do
      DIRECTORY_HISTORY[i]="${DIRECTORY_HISTORY[i + 1]}"
    done
    DIRECTORY_HISTORY[$#DIRECTORY_HISTORY]=()

  else
    echo "Invalid index" >&2
    exit 1
  fi
}

# Had to repeat the deletion code because using $(delete_history_dir) didn't modify the global DIRECTORY_HISTORY
# due to being executed in a subshell
function cd_hist_dir() {
  setopt localoptions no_ksh_arrays
  local index=$1

  if [[ $index -ge 1 && $index -le $#DIRECTORY_HISTORY ]]; then
    local directory=${DIRECTORY_HISTORY[$index]}

    for ((i = index; i <= $#DIRECTORY_HISTORY; i++)); do
      DIRECTORY_HISTORY[i]="${DIRECTORY_HISTORY[i + 1]}"
    done
    DIRECTORY_HISTORY[$#DIRECTORY_HISTORY]=()

  else
    echo "Invalid index" >&2
    exit 1
  fi

  push_dir $directory
}

function open_directory_history {
  local dirs=()
  for ((i = $#DIRECTORY_HISTORY; i > 0; --i)); do
    dirs+="$i\t$DIRECTORY_HISTORY[$i]"
  done
 
  selection=$( IFS=$'\n'; echo "$dirs" | \
    rofi -dmenu \
    -keep-right \
    -theme ~/.config/rofi/themes/launcher.rasi \
    -kb-custom-1 "Ctrl+d"); # \
    # -display-columns 2);

  rofi_exit_code=$?

  dir_idx=$(echo $selection | cut -f 1);

  if [[ $rofi_exit_code -eq 10 ]]; then
    delete_history_dir $dir_idx 1>/dev/null
    open_directory_history
  elif [[ -n $dir_idx ]]; then
    zle push-line # Keep command in promp without executing it.
    cd_hist_dir $dir_idx
    zle accept-line
  fi
}
zle -N open_directory_history

# function _push_dir() {
#   _path_files -/
# }

# compdef _push_dir push_dir
