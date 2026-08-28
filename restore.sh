#!/usr/bin/env bash
set -euo pipefail

# restore.sh — mirror opencode/ into ~/.config/opencode
# 4 skills (learn-go-with-tests book pedagogy via MCP + 3 companions), opencode.json only.

DEST="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"
SRC="$(cd "$(dirname "$0")" && pwd)/opencode"
[[ -d "$SRC" ]] || { echo "error: $SRC not found" >&2; exit 1; }

BACKUP_DIR=""
backup() {
  local dst="$1"
  [[ -n "$BACKUP_DIR" ]] || BACKUP_DIR="$DEST/.restore-backup-$(date +%Y%m%d-%H%M%S)"
  mkdir -p "$BACKUP_DIR/$(dirname "${dst#"$DEST"/}")"
  cp -a "$dst" "$BACKUP_DIR/${dst#"$DEST"/}"
  echo "BAK  ${dst#"$DEST"/} -> $BACKUP_DIR/${dst#"$DEST"/}"
}

while IFS= read -r -d '' f; do
  dst="$DEST/${f#"$SRC"/}"
  [[ -f "$dst" ]] && ! cmp -s "$f" "$dst" && backup "$dst"
  mkdir -p "$(dirname "$dst")"
  cp "$f" "$dst"
  echo "OK   ${dst#"$DEST"/}"
done < <(find "$SRC" -type f -print0 | sort -z)

echo
echo "Restore complete. Restart opencode."
