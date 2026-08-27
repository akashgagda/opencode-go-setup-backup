#!/usr/bin/env bash
set -euo pipefail

# restore.sh — restore opencode config from this backup
#
# Mirrors opencode/ into ~/.config/opencode (or $OPENCODE_CONFIG_DIR).
# Current stack (2026-08-28): 4 skills — learn-go-with-tests (book-owned via
# GitBook MCP searchDocumentation->getPage verbatim, citation none) +
# concept-explainer/socratic-tutor/study-habit-coach (2-file load-bearing,
# no glossary, no deeptutor), tui: system + codeLens:false + inlayHints:false,
# tui.jsonc plugin: [] (herdr optional, not bundled), no .mcp.json, no .commandcode.
#
# Behavior: files that differ are overwritten and first backed up to
# .restore-backup-<timestamp>/ inside DEST. Deprecated artifacts
# (deeptutor, herdr) not in SRC are pruned with backup. Plugin runtime
# (@opencode-ai/plugin) is installed when package.json is present but
# node_modules is missing.

DEST="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"
SRC="$(cd "$(dirname "$0")" && pwd)/opencode"

if [[ ! -d "$SRC" ]]; then
  echo "error: $SRC not found — run restore.sh from the repo root" >&2
  exit 1
fi

# Safety net: before overwriting or deleting a file that differs from the
# backed-up copy, move the existing one into a timestamped .restore-backup-* dir.
BACKUP_DIR=""

backup_path() {
  local dst="$1"
  if [[ -z "$BACKUP_DIR" ]]; then
    BACKUP_DIR="$DEST/.restore-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"
  fi
  local rel="${dst#"$DEST"/}"
  mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
  if [[ -d "$dst" ]]; then
    cp -a "$dst" "$BACKUP_DIR/$rel"
  else
    cp "$dst" "$BACKUP_DIR/$rel"
  fi
  echo "BAK  $rel -> $BACKUP_DIR/$rel"
}

install_file() {
  local src="$1" dst="$2"
  if [[ -f "$dst" ]] && ! cmp -s "$src" "$dst"; then
    backup_path "$dst"
  fi
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  echo "OK   ${dst#"$DEST"/}"
}

prune_path() {
  local rel="$1"
  local dst="$DEST/$rel"
  if [[ -e "$dst" ]]; then
    backup_path "$dst"
    rm -rf "$dst"
    echo "DEL  $rel (deprecated, not in backup)"
  fi
}

# Copy the whole opencode/ tree, mirroring the layout of ~/.config/opencode.
while IFS= read -r -d '' f; do
  install_file "$f" "$DEST/${f#"$SRC"/}"
done < <(find "$SRC" -type f -print0 | sort -z)

# Prune deprecated artifacts that were removed from the backup but may remain
# in a live config from an earlier restore (deeptutor skill, herdr integration).
# These are pruned with backup so the user can recover if needed.
prune_path "skills/deeptutor/SKILL.md"
# Remove empty deeptutor dir if it remains after file prune
if [[ -d "$DEST/skills/deeptutor" ]]; then
  # Only remove if empty or only contains pruned file backup
  rmdir "$DEST/skills/deeptutor" 2>/dev/null || true
fi
prune_path "herdr-tui-session.js"
prune_path "plugins/herdr-agent-state.js"
# Clean up empty plugins dir left behind after herdr removal? Keep it if
# backup has an empty plugins dir marker — but git doesn't track empty dirs,
# so DEST/plugins may remain. Leave it; it's harmless.
# Also prune any stray .commandcode artifact that might have been copied historically.
prune_path ".commandcode/settings.json"
if [[ -d "$DEST/.commandcode/taste" ]]; then
  backup_path "$DEST/.commandcode"
  rm -rf "$DEST/.commandcode"
  echo "DEL  .commandcode (deprecated, not in backup)"
fi
# Prune stray .mcp.json that lived in the opencode config historically (if ever).
prune_path ".mcp.json"

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
echo "Skills auto-load — just ask (e.g. \"teach me Go\" — 3-skill stack + book-owned anchors)."
echo "Vault (go-learning): dashboard+learning-board load-bearing, glossary archived, no .mcp.json."
