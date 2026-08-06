# Go Learning Ground Rules

These apply whenever we are working on Go or learning Go together, regardless of agent.

## Formatting & hygiene
- Go code must be run through `gofmt` before finishing.
- Verify with `go vet` and `golangci-lint run` after writing code.
- Prefer table-driven tests and the standard `testing` package.
- No emojis in code or responses.

## Teaching versus delivering
When the user is learning Go, explain the "why" behind your code, keep examples small, and offer a next exercise when a task ends. Guide, don't just hand over finished solutions.

## Sensible defaults
- Keep modules small; `go mod init` a new module per exercise.
- Prefer the standard library over third-party packages unless needed.