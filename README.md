# opencode Setup Backup

Backup of my opencode configuration, skills, and TUI/plugin wiring — for restoring
on a new machine (or recovering after a wipe). Run `./restore.sh` and you're back.

## What's included

The `opencode/` directory mirrors `~/.config/opencode/`:

- `opencode/opencode.json` — global config
  - **Learn Go With Tests** MCP (remote GitBook)
  - **gopls** MCP (local, official Go code-intelligence tools: `go_search`, `go_diagnostics`, `go_symbol_references`, `go_vulncheck`, `go_file_context`, `go_package_api`)
  - **pkgsite** MCP (local, wraps the pkg.go.dev v1beta API: `pkgsite_search`, `pkgsite_package`, `pkgsite_symbols`, `pkgsite_vulns`, …)
  - auto-allow permissions for Go toolchain, git, and `obsidian` commands
  - `autoupdate: false`
- `opencode/tui.json` — TUI theme
- `opencode/tui.jsonc` — TUI plugins (`./herdr-tui-session.js`)
- `opencode/skills/` — the skill library, auto-loaded by opencode:
  - `learn-go-with-tests` — the Go tutor (test-first, red → green → refactor). This replaces the old `go-tutor` agent + `learning-style.md`
  - `concept-explainer` — explain any concept with progressive depth + a check for understanding
  - `socratic-tutor` — teach by asking questions, not handing over answers
  - `study-habit-coach` — build a repeatable study habit (tiny actions, friction fixes)
  - `deeptutor` — drive the DeepTutor CLI: `deep_solve`, `deep_question`, `deep_research`, knowledge bases, partners, sessions, notebooks, …
- `opencode/plugins/herdr-agent-state.js` + `opencode/herdr-tui-session.js` — [herdr](https://herdr.app) → opencode pane integration. Managed by herdr: reinstalling the integration regenerates them, so restore is just a safety net.
- `opencode/package.json` / `opencode/package-lock.json` — `@opencode-ai/plugin` runtime dependency for plugins (restore runs `npm install` / `bun install` automatically when needed).

## Prerequisites (new machine)

- [opencode](https://opencode.ai) CLI (e.g. via [mise](https://mise.jdx.dev))
- Go toolchain (e.g. via [mise](https://mise.jdx.dev))
- gopls — `go install golang.org/x/tools/gopls@latest` (or via mise)
- pkgsite — `go install github.com/hegner123/pkgsite@latest` (MCP server for pkg.go.dev docs)
- golangci-lint — `mise use -g golangci-lint@v2.12.2` (or their [official install](https://golangci-lint.run/welcome/install/))
- [herdr](https://herdr.app) — optional; only if you want the pane/session integration
- [obsidian](https://github.com/Yakitrak/obsidian-cli) CLI — optional; for opening vault notes from the CLI

## Restore

```bash
# 1. install prerequisites (see above)

# 2. copy the whole config tree into place
./restore.sh

# 3. restart opencode (config + MCP are loaded on startup, not hot-reloaded)
```

`restore.sh` copies the `opencode/` tree into `~/.config/opencode/` (override with
`OPENCODE_CONFIG_DIR`), mirroring the live layout. The repo is the source of truth:
files that differ are overwritten, and anything overwritten is first moved to
`.restore-backup-<timestamp>/` inside the config dir. If a `package.json` is present
but `node_modules/` is missing, it runs `bun install` (or `npm install`) there.

## Daily use

- **Go tutoring** — the `learn-go-with-tests` skill drives test-first sessions in
  the `~/Projects/go-learning` workspace: a single Go module with one package per
  chapter plus an Obsidian vault (`notes/learning-board.md` kanban, per-chapter
  notes, `glossary.md`) and its own `AGENTS.md`. That workspace is versioned
  separately at github.com/akashgagda/go-learning.
- **General tutoring** — `concept-explainer`, `socratic-tutor`, and
  `study-habit-coach` are generic and apply to any subject.
- **DeepTutor** — the `deeptutor` skill covers the CLI platform end to end
  (dedicated workspace: `/home/akash/Work/my-deeptutor`).

Skills load automatically in opencode — there is no agent to switch to. Just ask,
e.g. "teach me Go" or "walk me through this problem".

## Notes

- The old setup (`go-tutor` agent, `learning-style.md`, `/notes` command) was
  replaced by the skill library plus the workspace's own rules; see git history.
- gopls MCP runs in detached mode (`gopls mcp`), so it only sees saved files.
- pkgsite MCP wraps pkg.go.dev's v1beta API, so agents can look up official Go docs instead of guessing.
- `default_agent` is intentionally NOT set, so no agent hijacks sessions.
