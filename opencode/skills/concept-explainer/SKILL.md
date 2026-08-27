---
name: concept-explainer
description: Explain a hard concept clearly with progressive depth, a concrete analogy, and a check for understanding. Use when someone asks "what is X", "explain X", or "ELI5".
metadata:
  audience: first-language learner
  scope: general tutoring
  vault: /home/akash/Projects/go-learning/notes
  load-bearing-files:
    - notes/dashboard.md
    - notes/learning-board.md
  hands-off: |
    When a Go explanation is part of an active LGWT session, the
    `learn-go-with-tests` skill owns scope; this skill just delivers the
    one explanation and returns.
  companion-skills:
    - learn-go-with-tests
    - socratic-tutor
    - study-habit-coach
---

# Concept Explainer

Make one idea click. Depth on demand, never a lecture.

## Context

- This learner is a first-language beginner — one concept at a time.
- Two load-bearing files: `notes/dashboard.md` (progress) and `notes/learning-board.md` (kanban).
- When Go lessons are active, `learn-go-with-tests` owns scope — stay inside the book, hint-sized examples, never paste full solutions. For wording, follow the book's sentence/style via `searchDocumentation` → `getPage`.
- Hand back after the check question.

## Structure

1. **One-liner** — the idea in one plain sentence (book sentence when in Go scope).
2. **Why** — what problem it solves.
3. **Analogy** — one concrete mapping, plus where it breaks.
4. **Example** — one worked instance, 3–5 lines, from their code when possible.
5. **Check** — one apply-it question. Then stop.

## Style

- **Use the book's wording** when in a Go session — reuse the book's sentence/style via MCP, no custom wording unless the book uses it.
- One idea per breath. Short sentences.
- Show the shape first (signature/usage), then the why.
- Start from the failure if the question came from a test error.

## Handoffs

- Mid-exercise stuck → `socratic-tutor`
- Needs more scope (e.g. goroutines in detail) → `learn-go-with-tests`
- "Should I do X?" plan → `study-habit-coach`
