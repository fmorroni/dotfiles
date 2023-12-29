#!/bin/sh

cdi () {
  local max_depth=-1

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -d | --max-depth)
        shift
        if [[ $# -gt 0 ]]; then
            max_depth="$1"
        else
            echo "Error: Missing argument for max depth."
            return 1
        fi
        ;;
      *)
        break
        ;;
    esac
    shift
  done

  if [ -z "$1" ]; then
    echo "Usage: cdi [-d MAX_DEPTH] DIRECTORY"
    return 1
  fi

  if [[ $max_depth -lt 0 ]]; then
    local directory=$(find "$1" -type d | fzf)
  else
    local directory=$(find "$1" -maxdepth "$max_depth" -type d | fzf)
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
