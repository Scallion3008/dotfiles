#!/bin/bash
set -euo pipefail

DIRS=(fish kitty mako nvim sway waybar)

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
echo "workdir is $SCRIPT_DIR"

for dir in "${DIRS[@]}"; do
  target="$SCRIPT_DIR/$dir"
  link_name="$HOME/.config/$dir"
  echo "symlinking $link_name -> $target"
  ln -s "$target" "$link_name"
done
