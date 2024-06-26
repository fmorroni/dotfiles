cdi_usage () {
  echo "Usage: cdi [[ -d MAX_DEPTH ] xor [ -p 'TO-PRUNE-1 ... TO-PRUNE-N' ]] <DIRECTORY>"
  echo "Options:"
  echo "  -d | --max-depth <depth>"
  echo "  -p | --prune <space separated string of directory names to prune>"
}

cdi () {
  local max_depth_set=false
  local prune_set=false

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -d | --max-depth)
        if [[ "$prune_set" = true ]]; then
          echo "Error: --max-depth does not work with --prune.\n"
          cdi_usage
          return 1
        else
          if [[ $# -ge 3 ]]; then
            max_depth_set=true
            local max_depth="$2"
            shift 2
          else
            echo "Error: Missing argument for --max-depth.\n"
            cdi_usage
            return 1
          fi
        fi
        ;;
      -p | --prune)
        if [[ "$max_depth_set" = true ]]; then
          echo "Error: --prune does not work with --max-depth.\n"
          cdi_usage
          return 1
        else
          if [[ $# -ge 3 ]]; then
            prune_set=true
            local to_prune_dirs=$2
            local to_prune=()
            # for dir in $=to_prune_dirs; do
            for dir in ${(ps: :)to_prune_dirs}; do
              to_prune+=('-name')
              to_prune+=("$dir")
              to_prune+=('-o')
            done
            to_prune[-1]=()
            shift 2
          else
            echo "Error: Missing argument for --prune.\n"
            cdi_usage
            return 1
          fi
        fi
        ;;
      *)
        break
        ;;
    esac
  done

  if [ -z "$1" ]; then
    cdi_usage
    return 1
  fi

  if [[ "$max_depth_set" = true ]]; then
    local directory=$(find "$1" -maxdepth "$max_depth" -type d | fzf)
  elif [[ "$prune_set" = true ]]; then
    local directory=$(find "$1" \( "${to_prune[@]}" \) -prune -o -type d | fzf)
  else
    local directory=$(find "$1" -type d | fzf)
  fi

  if [ -n "$directory" ]; then
    cd "$directory"
  fi
}

# cdi_current_dir() {
#   cdi .
# }
# zle -N cdi_current_dir

function vi-yank-xclip {
  zle vi-yank
  echo "$CUTBUFFER" | xclip -selection clipboard
}
zle -N vi-yank-xclip

function vi-yank-eol-xclip {
	zle vi-yank-eol
  echo "$CUTBUFFER" | xclip -selection clipboard
}
zle -N vi-yank-eol-xclip

function mvn-itba {
  if [[ -z $1 ]]; then
    echo "Usage: $(basename $0) <artifact id> [version]"
    return 1
  fi
  mvn archetype:generate \
    -DarchetypeGroupId=itba.EDA \
    -DarchetypeArtifactId=eda-project \
    -DgroupId=itba.EDA \
    -DartifactId="$1" \
    -Dversion="${2:-1.0}" \
    -DinteractiveMode=false
}

function cat-exec {
  cat $(which $1)
}
compdef _path_commands cat-exec

function trestore_fzf {
  indexes=$(trash list | fzf --multi | awk '{$1=$1;print}' | cut -d ' ' -f 1)
  trash restore -r "$indexes"
}

function wpp-converter {
  ffmpeg -i $1 \
    -vf "scale=-2:480" \
    -c:v libx264 \
    -preset slow \
    -crf 21 \
    -profile:v baseline \
    -level 3.0 \
    -pix_fmt yuv420p \
    -r 25 \
    -g 50 \
    -c:a aac \
    -b:a 160k \
    -r:a 44100 \
    -f mp4 "${1%.*}""_wpp.mp4"
      # -af "aformat=channel_layouts=stereo,highpass=f=40,volume=1.40,compand=attacks=0.1 0.1:decays=3.0 3.0:points=-900/-900 -100/-70 -70/-45 -45/-30 -40/-15 -20/-9 -10/-6 0/-4:soft-knee=0.50:gain=0:volume=-900:delay=3.0" \
}

function local_gitaux {
  command_name=$1
  git_action=$2
  title=$3
  desc=''
  shift 3
  if [[ -z $title ]]; then
    echo "Usage: $command_name <commit message> [commit description line 1] ... [commit description line n]" 1>&2
    return 1
  elif [[ $# -gt 0 ]]; then
    desc='-m'
    for msg in $@; do
      desc+=$msg$'\n'
    done
  fi
  git commit -m "$git_action: $title" $desc
}
function gitfeat {
  local_gitaux "$0" 'feat' "$@"
}
function gitchore {
  local_gitaux "$0" 'chore' "$@"
}
function gitfix {
  local_gitaux "$0" 'fix' "$@"
}

function configadd() {
  config add $@
}
compdef _rm configadd

function confignew() {
  config commit -m "Feat: add $1 config"
}

function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd "$cwd"
	fi
	\rm -f -- "$tmp"
}

function user-mount() {
  local label=${$(lsblk $(blkid --uuid $1) -o LABEL --noheadings):-"no-label"}
  local mntdir="$MNT_DIR/$label-$1"
  mkdir -p "$mntdir"
  sudo mount -o uid="$USER",gid="$USER",fmask=113,dmask=002 UUID="$1" "$mntdir"
  [ $? -eq 0 ] || return
  echo "Device mounted at $mntdir"
}

function user-unmount() {
  local dir="$MNT_DIR/$1"
  sudo umount "$dir"
  [ $? -eq 0 ] || return
  rmdir "$dir"
  echo "It's safe to remove the device"
}

function passf() {
  local passPaths=($(find $HOME/.password-store -type f -iname "$1.gpg" | sed 's|^.*\.password-store/||; s/\.gpg$//'))
  if [ -z "$passPaths" ]; then
    echo "No pass found matching '$1'"
    return 1
  fi
  for passPath in $passPaths; do
    echo "Showing $passPath:"
    pass $passPath
    echo
  done
}

# Needed if using kitty
scroll-and-clear-screen() {
  printf '\n%.0s' {1..$LINES}
  zle clear-screen
}
zle -N scroll-and-clear-screen
bindkey '^l' scroll-and-clear-screen

ps-parent() {
  if [[ $# -lt 1 ]]; then
    echo "Usage: ps-parent <pid_1> [pid_2] ... [pid_n]"
    return 1
  fi
  for pid in $@; do
    ps f -p "$pid" --ppid "$pid" -o "pid,ppid,stat,tty,cmd"
    echo
  done
}

lsfd-custom() {
  if [[ $# -lt 1 ]]; then
    echo "Usage: lsfd-custom <pid_1> [pid_2] ... [pid_n]"
    return 1
  fi
  for pid in $@; do
    lsfd -p "$pid" | awk 'NR==1 {print; next} $8 != 0'
    echo
  done
}

open-terminal-in-cwd() {
  # nohup and redirections are needed so the parent terminal
  # is able to exit even if the child is active (this is a kitty thing)
  # (and ! after & is a zsh thing apparently)
  nohup kitty >/dev/null 2>/dev/null &!
}
zle -N open-terminal-in-cwd
