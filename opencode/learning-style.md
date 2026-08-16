# Go Learning Ground Rules

These apply whenever we are working on Go or learning Go together, regardless of agent.

## Formatting & hygiene
- Go code must be run through `gofmt` before finishing.
- Verify with `go vet` and `golangci-lint run` after writing code.
- Prefer table-driven tests and the standard `testing` package.
- No emojis in code or responses.

## Teaching versus delivering
When the user is learning Go, explain the "why" behind your code, keep examples small, and offer a next exercise when a task ends. Guide, don't just hand over finished solutions.

While learning a new concept, the student writes the code: do not write or edit the `.go` files that are the lesson until the student has attempted it themselves or explicitly asked for the answer. One step per turn, then wait for the student. If they ask to restart, find out why first instead of repeating the same approach.

## Sensible defaults
- Keep modules small; `go mod init` a new module per exercise.
- Prefer the standard library over third-party packages unless needed.

## Package documentation
- Look up official Go package docs via the `pkgsite_*` MCP tools (e.g. `pkgsite_package`, `pkgsite_symbols`) instead of guessing or relying on memory. These wrap the pkg.go.dev v1beta API.

## Notes & Obsidian
The vault is `~/Projects/go-learning/notes/` (an Obsidian vault, driven via the `obsidian` CLI). When writing or editing study notes, follow these conventions so the dashboard, board, and flashcards stay consistent:

- Every chapter note has YAML frontmatter: `chapter` (two-digit number), `title`, `status` (`todo`/`in-progress`/`done`), `date`, and `tags: [go, chapter]`. The Dataview dashboard reads this — without it the chapter won't appear.
- Self-test questions are Spaced Repetition single-line flashcards: `Question?::Answer #flashcards`.
- Dataview trap: never write a backtick immediately followed by `=` (e.g. `` `==` ``) in note text — it is Dataview's inline-query trigger and renders a `PARSING FAILED` error in Obsidian. Write `==` as plain text instead.
- TDD checklist items in a chapter note carry the `#task` tag (the Tasks plugin tracks them); plain `- [ ]` items are ignored by Tasks.
- When a chapter is finished, prefer `/notes <chapter>` over hand-writing a note — it writes the file, opens it in Obsidian, and moves the card on `learning-board.md` to Done.
- `dashboard.md` (Dataview) and `learning-board.md` (Kanban) are maintained by the `/notes` flow; when editing notes by hand, keep `learning-board.md` cards in sync with chapter status.
- `glossary.md` uses a `| Term | Meaning | Example |` table; append rows rather than reformatting.
- Drawings live in `notes/drawings/` (Excalidraw).