#!/bin/bash

# SCREEN_RECS="${SCREEN_RECS%%/}"
SCREEN_RECS="${SCREEN_RECS%%/}"

echo -e "\0prompt\x1fRecordings"
echo -e "\0use-hot-keys\x1ftrue"

if [[ -n $ROFI_DATA ]]; then
  rec_dir="$ROFI_DATA"
else
  rec_dir="$SCREEN_RECS"
fi
rec_dir="${rec_dir%%/}"

full_selection=$(realpath "$rec_dir/$1")
# Check if full_selection is subdirectory of SCREEN_RECS
if [[ "$full_selection" == "$SCREEN_RECS"* ]]; then
  if [[ $ROFI_RETV -eq 10 && ! -e "$full_selection" ]]; then
    mkdir -p "$full_selection"
    echo "Sel: $full_selection"
  elif [ -d "$full_selection" ]; then
    rec_dir="$full_selection" 
  elif [ -f "$full_selection" ]; then
    # Here will go a rofi confirmation pop up
    echo "$OVERWRITE $full_selection" 1>&2
    exit
  elif [ ! -e "$full_selection" ]; then
    # ffcast -s rec "$full_selection"
    echo "$NEW $full_selection" 1>&2
    exit
  fi
fi

if [[ "${rec_dir%%/}" != "${SCREEN_RECS%%/}" ]]; then
  echo ".."
fi

echo -e "\0data\x1f$rec_dir"
echo -e "\0message\x1fCurrent dir: $rec_dir"

for filename in $(ls -1 "$rec_dir"); do
  path="$rec_dir/$filename"
  if [ -d "$path" ]; then
    echo -e "$filename\0icon\x1ffolder"
  else
    echo "$filename"
  fi
done

# echo "Ret val: $ROFI_RETV"
