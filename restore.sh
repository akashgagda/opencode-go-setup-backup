#!/usr/bin/env bash
set -euo pipefail

DEST="${OPENSE_CONFIG_DIR:-$HOME/.config/opencode}"
SRC="$(cd "$(dirname "$0")" && pwd)/opencode"

restore_file() {
  local rel="$1"
  local src="$SRC/$rel"
  local dst="$DEST/$rel"
  if [[ -f "$dst" ]] && ! cmp -s "$src" "$dst"; then
    echo "SKIP $rel -> $dst already exists and differs (not overwritten)"
    return
  fi
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  echo "OK   $rel -> $dst"
}

restore_file "opencode.json"
restore_file "learning-style.md"
restore_file "agent/go-tutor.md"

echo
echo "Restore complete. Quit and restart opencode for changes to take effect."
echo "Then switch to the tutor with: /agent go-tutor"