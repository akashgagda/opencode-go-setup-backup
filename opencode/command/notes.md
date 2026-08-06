---
description: Create a concise markdown study note for a finished Go learning chapter. Usage: /notes <chapter> where chapter is a folder name or number (e.g. /notes 04 or /notes 04-structs-methods-interfaces).
agent: go-tutor
---

Create a concise study note for the Go chapter the user just finished.

## Resolve the chapter path

The course lives at `~/Projects/go-learning/`. `$ARGUMENTS` contains the chapter as a folder name or number. Resolve it:

- If `$ARGUMENTS` is all digits (e.g. `04`), find the folder in `~/Projects/go-learning/` starting with that two-digit prefix.
- Otherwise treat `$ARGUMENTS` as the exact folder name (e.g. `04-structs-methods-interfaces`).
- Confirm the folder exists before proceeding. If it does not, list the chapter folders and ask the user to confirm.

## Refuse to clobber

The note lives at `~/Projects/go-learning/notes/<chapter>.md`. If that file already exists, do NOT overwrite it. Tell the user the note exists and ask whether to (a) append a new section, (b) replace it, or (c) leave it. Proceed only per their choice.

## Gather context

- Read the `.go` files in the chapter folder (the test file first, then the source).
- Run `go test ./<chapter-folder>/...` from `~/Projects/go-learning/` and capture the result line.
- If useful, use the `learn-go-with-tests` MCP server for the corresponding course page to confirm concepts.

## Write the note (concise)

Structure `~/Projects/go-learning/notes/<chapter>.md` with:

```markdown
# <Chapter Name>

## Concepts learned
- bullet list of concepts / new Go idioms, short

## Key snippet
```go
// single most valuable code idea from this chapter
```

## Gotchas / mental model
- one or two bullets: what trips people up, or the key mental model

## Tests
`go test <pkg>` → PASS/FAIL summary line

## Self-test
- one review question to answer from memory later
```

Keep it concise: a bullet or two per section, one snippet, one review question. Write in a clear, plain tone. Do not pad.

After writing, print the path of the note and tell the user it is saved.