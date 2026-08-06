# opencode Go Learning Setup Backup

Backup of the opencode setup used for learning Go with MCP, for future restore.

## What's included

- `opencode/opencode.json` — global opencode config
  - **Learn Go with Tests** MCP (remote GitBook)
  - **gopls** MCP (local, official Go code-intelligence tools: `go_search`, `go_diagnostics`, `go_symbol_references`, `go_vulncheck`, `go_file_context`, `go_package_api`)
  - permission auto-allow for `go test`, `go vet`, `golangci-lint`
  - loads `learning-style.md` as shared instructions
- `opencode/agent/go-tutor.md` — a primary "Go tutor" agent teaching the TDD cycle
- `opencode/learning-style.md` — shared Go learning ground rules
- `opencode/command/notes.md` — `/notes <chapter>` command that writes a concise study note after each finished chapter

## Prerequisites (new machine)

- Go toolchain (e.g. via [mise](https://mise.jdx.dev))
- gopls — `go install golang.org/x/tools/gopls@latest` (or via mise)
- golangci-lint — `mise use golangci-lint` (or their [official install](https://golangci-lint.run/welcome/install/))
- opencode CLI

## Restore

```bash
# 1. install prerequisites (see above)

# 2. copy config into place
./restore.sh

# 3. restart opencode (config + MCP are loaded on startup, not hot-reloaded)

# 4. switch to the tutor agent in a session
#    opencode > /agent go-tutor
```

## Daily use

- `/agent go-tutor` — switch to the Go tutor agent for a session
- `/notes <chapter>` (e.g. `/notes 04`) — after finishing a chapter, writes a concise note to `~/Projects/go-learning/notes/<chapter>.md`

The `restore.sh` script copies the files into `~/.config/opencode/`. Backing up
any existing files, it will refuse to overwrite a config file that already
differs from the backed-up copy, so your active config is never clobbered.

## Notes

- gopls MCP runs in detached mode (`gopls mcp`), so it only sees saved files.
- `default_agent` is intentionally NOT set to `go-tutor` so it does not hijack sessions.