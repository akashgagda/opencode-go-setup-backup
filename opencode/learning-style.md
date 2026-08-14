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