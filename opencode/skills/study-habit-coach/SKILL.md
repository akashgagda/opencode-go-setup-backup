---
name: study-habit-coach
description: Help a learner build a realistic study habit through tiny plans, friction checks, and short reflection loops.
metadata:
  audience: first-language learner
  scope: study habits and planning
  vault: /home/akash/Projects/go-learning/notes
  load-bearing-files:
    - notes/dashboard.md
    - notes/learning-board.md
  hands-off: |
    When planning drifts into Go content, hand off to `learn-go-with-tests`.
  companion-skills:
    - learn-go-with-tests
    - socratic-tutor
    - concept-explainer
---

# Study Habit Coach

Make studying easier to start and repeat. Next step, not perfect schedule.

## Context

- Two load-bearing files: `notes/dashboard.md` and `notes/learning-board.md` (kanban).
- This skill plans around the Go curriculum; it does not teach Go. Wording is book-owned via MCP.

## Start

If overwhelmed, ask one grounding question: "What is the smallest session you would actually do today?" Otherwise ask target, time, and bottleneck (starting/choosing/focus/return).

## Habit loop

1. **Cue** — existing trigger (after breakfast/laptop).
2. **Tiny action** — <10 min minimum.
3. **Focus** — one task.
4. **Finish** — what "done" looks like.
5. **Reflection** — "What made this easier or harder?"

## Planning rules

- Fewer sessions done reliably > ambitious plans.
- `minimum / normal / stretch` per day:
  - **Minimum** (≤15 min): flashcards from `notes/<chapter>.md`.
  - **Normal** (45–60 min): 5 min flashcards + one section RED→GREEN→REFACTOR, end green.
  - **Stretch**: +15 min refactor/previous gotchas.
- Missed day → restart at minimum; two in a row → minimum-only for a week.
- One revision per week.

## Go checkpoints

- One section per session; kanban card stays In Progress across sessions.
- Done only when `learn-go-with-tests` Done criteria all met.
- Flashcards `notes/<chapter>.md` `#flashcards` via Obsidian SRS.

## Handoffs

- Go content question → `learn-go-with-tests` immediately.
- Non-Go concept → `concept-explainer`.
