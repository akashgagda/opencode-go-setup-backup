# opencode Setup Backup

Backup of `~/.config/opencode` — run `./restore.sh` to restore.

## What's included

`opencode/` mirrors the live config:

- `opencode.json` — `learn-go-with-tests` (GitBook) + `gopls` + `pkgsite` MCPs, Go/obsidian allows, `autoupdate: false`
- `cli.json` — TUI prefs (system theme, scrollbar, hide sidebar, tabs disabled)
- `skills/` — `learn-go-with-tests` (book pedagogy via MCP) + `concept-explainer` / `socratic-tutor` / `study-habit-coach`

## Prerequisites

- `opencode` CLI (e.g. via [mise](https://mise.jdx.dev))
- Go toolchain (e.g. via [mise](https://mise.jdx.dev))
- gopls — `go install golang.org/x/tools/gopls@latest` (or via mise)
- pkgsite — `go install github.com/hegner123/pkgsite@latest` (MCP server for pkg.go.dev docs)
- golangci-lint — `mise use -g golangci-lint@v2.13.2` (or their [official install](https://golangci-lint.run/welcome/install/))

## Restore

```bash
./restore.sh
# restart opencode (config loads on startup)
```

Mirrors `opencode/` into `~/.config/opencode` (`$OPENCODE_CONFIG_DIR` to override); backs up overwrites to `.restore-backup-*`.

## Daily use

- **Go** — `learn-go-with-tests` in `~/Projects/go-learning` (one package per chapter, vault `dashboard.md` + `learning-board.md`, glossary archived)
- **General** — `concept-explainer` / `socratic-tutor` / `study-habit-coach`

Skills auto-load — just ask `teach me Go`.
