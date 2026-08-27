# opencode Setup Backup

Backup of `~/.config/opencode` — run `./restore.sh` to restore.

## What's included

`opencode/` mirrors the live config:

- `opencode.json` — `learn-go-with-tests` (GitBook) + `gopls` + `pkgsite` MCPs, Go/obsidian allows, `autoupdate: false`
- `tui.json` / `tui.jsonc` — theme `system`, `plugin: []`
- `skills/` — `learn-go-with-tests` (book pedagogy via MCP) + `concept-explainer` / `socratic-tutor` / `study-habit-coach`
- `plugins/`, `package.json` — optional integrations

## Prerequisites

- `opencode` CLI, Go toolchain, `gopls`, `pkgsite`, `golangci-lint`

## Restore

```bash
./restore.sh
# restart opencode (config loads on startup)
```

Mirrors `opencode/` into `~/.config/opencode` (`$OPENCODE_CONFIG_DIR` to override); backs up overwrites to `.restore-backup-*`; runs `bun`/`npm install` if needed.

## Daily use

- **Go** — `learn-go-with-tests` in `~/Projects/go-learning` (one package per chapter, vault `dashboard.md` + `learning-board.md`, glossary archived)
- **General** — `concept-explainer` / `socratic-tutor` / `study-habit-coach`

Skills auto-load — just ask `teach me Go`.

## Notes

- Replaces old `go-tutor`/`learning-style.md`/`deeptutor`/glossary/plain-words — book pedagogy via `searchDocumentation→getPage` verbatim.
- `gopls mcp` is detached (saved files only); `default_agent` not set.
