#!/usr/bin/env bash
set -euo pipefail

# restore.sh — mirror opencode/ into ~/.config/opencode
# Book-close: 4 skills (learn-go-with-tests book pedagogy via MCP + 3 companions),
# 2-file vault, tui system, plugin [].

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

# plugin runtime
if [[ -f "$DEST/package.json" ]] && ! [[ -d "$DEST/node_modules" ]]; then
  if command -v bun >/dev/null 2>&1; then
    (cd "$DEST" && bun install --no-progress) || echo "warn: bun install failed"
  elif command -v npm >/dev/null 2>&1; then
    (cd "$DEST" && npm install --no-fund --no-audit) || echo "warn: npm install failed"
  fi
fi

echo
echo "Restore complete. Restart opencode."
