---
description: Create a concise markdown study note for a finished Go learning chapter, saved into the Obsidian vault with flashcards, and open it in Obsidian. Usage: /notes <chapter> where chapter is a folder name or number (e.g. /notes 04 or /notes 04-structs-methods-interfaces).
agent: go-tutor
---

Create a concise study note for the Go chapter the user just finished, following the vault conventions.

## Resolve the chapter path

The course lives at `~/Projects/go-learning/`. `$ARGUMENTS` contains the chapter as a folder name or number. Resolve it:

- If `$ARGUMENTS` is all digits (e.g. `04`), find the folder in `~/Projects/go-learning/` starting with that two-digit prefix.
- Otherwise treat `$ARGUMENTS` as the exact folder name (e.g. `04-structs-methods-interfaces`).
- Confirm the folder exists before proceeding. If it does not, list the chapter folders and ask the user to confirm.
- Derive the two-digit `chapter` number from the folder prefix (e.g. `04`).

## Refuse to clobber

The note lives at `~/Projects/go-learning/notes/<chapter>.md`. If that file already exists, do NOT overwrite it. Tell the user the note exists and ask whether to (a) append a new section, (b) replace it, or (c) leave it. Proceed only per their choice.

## Gather context

- Read the `.go` files in the chapter folder (the test file first, then the source).
- Run `go test ./<chapter-folder>/...` from `~/Projects/go-learning/` and capture the result line.
- If useful, use the `learn-go-with-tests` MCP server for the corresponding course page to confirm concepts.

## Write the note (concise, vault-conventions)

Write `~/Projects/go-learning/notes/<chapter>.md` with frontmatter and flashcards so the Obsidian dashboard and Spaced Repetition pick it up:

```markdown
---
chapter: <NN>
title: <Chapter Name>
status: done
date: <YYYY-MM-DD>
tags: [go, chapter]
---

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
- Question one from this chapter?::Answer in the user's own words #flashcards
- Question two from this chapter?::Answer in the user's own words #flashcards
```

Use the real current date for `date`. The `chapter` value is the two-digit number, and `tags: [go, chapter]` is required for the dashboard. Self-test questions must be Spaced Repetition single-line cards in the `Question?::Answer #flashcards` format, grounded in what the chapter actually covered. Keep it concise; do not pad.

## Open it in Obsidian

After writing, run `obsidian open path=<chapter>.md` from `~/Projects/go-learning/` to open the note in Obsidian. If Obsidian is not running or the command fails, tell the user the note is saved at its path and they can open it in Obsidian directly.

## Update the learning board

Edit `~/Projects/go-learning/notes/learning-board.md`: move the matching chapter card (e.g. `- [ ] 06 - Pointers and Errors`) from the `In Progress` or `To Do` list into the `Done` list. Keep the other cards untouched. If no matching card exists, leave the board alone.

After all that, print the path of the note and tell the user it is saved.
