#!/usr/bin/env bash
set -euo pipefail

DEST="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"
SRC="$(cd "$(dirname "$0")" && pwd)/opencode"

if [[ ! -d "$SRC" ]]; then
  echo "error: $SRC not found — run restore.sh from the repo root" >&2
  exit 1
fi

# Safety net: before overwriting a file that differs from the backed-up copy,
# move the existing one into a timestamped .restore-backup-* dir inside DEST.
BACKUP_DIR=""

install_file() {
  local src="$1" dst="$2"
  if [[ -f "$dst" ]] && ! cmp -s "$src" "$dst"; then
    if [[ -z "$BACKUP_DIR" ]]; then
      BACKUP_DIR="$DEST/.restore-backup-$(date +%Y%m%d-%H%M%S)"
      mkdir -p "$BACKUP_DIR"
    fi
    local rel="${dst#"$DEST"/}"
    mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
    cp "$dst" "$BACKUP_DIR/$rel"
    echo "BAK  $rel -> $BACKUP_DIR/$rel"
  fi
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  echo "OK   ${dst#"$DEST"/}"
}

# Copy the whole opencode/ tree, mirroring the layout of ~/.config/opencode.
while IFS= read -r -d '' f; do
  install_file "$f" "$DEST/${f#"$SRC"/}"
done < <(find "$SRC" -type f -print0 | sort -z)

# Plugin runtime dependency (@opencode-ai/plugin). The herdr integration files
# don't import it, but other plugins may — install it when a manifest is present
# and a package manager is available. Failures here are non-fatal.
if [[ -f "$DEST/package.json" ]] && ! [[ -d "$DEST/node_modules" ]]; then
  if command -v bun >/dev/null 2>&1; then
    (cd "$DEST" && bun install --no-progress) || echo "warn: bun install failed"
  elif command -v npm >/dev/null 2>&1; then
    (cd "$DEST" && npm install --no-fund --no-audit) || echo "warn: npm install failed"
  else
    echo "warn: package.json present but no bun/npm found — run 'npm install' in $DEST"
  fi
fi

echo
echo "Restore complete. Quit and restart opencode for changes to take effect."
echo "Skills auto-load — just ask (e.g. \"teach me Go\")."
