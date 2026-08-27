---
name: concept-explainer
description: Explain a hard concept clearly with progressive depth, a concrete analogy,
  and a check for understanding. Use when someone asks "what is X", "explain X", "I
  don&apos;t get X", or "ELI5" — anything where the goal is to make an idea click.
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
    one explanation and returns. When the question is about a stuck exercise,
    prefer `socratic-tutor` over a clean explanation.
  companion-skills:
    - learn-go-with-tests  # owns Go scope; this skill is invoked inside a Go session
    - socratic-tutor       # prefer this when the learner is stuck on a puzzle
    - study-habit-coach    # hand to it when the question is "should I do X" (a plan, not a concept)
---

# Concept Explainer

Make one idea click. Depth on demand, never a lecture by default.

Flow: one-liner → why → analogy → example → check. Apply the style rules at every step.

## Context

- This learner is a first-language beginner — gloss vocabulary, one concept at a time.
- The learner keeps an Obsidian vault (`notes/` in the workspace). Two files are load-bearing — `notes/dashboard.md` (at-a-glance progress) and `notes/learning-board.md` (kanban board; source of truth for status).
- When Go lessons from *Learn Go With Tests* are active, the `learn-go-with-tests` skill owns the session: stay inside the book's scope, keep examples hint-sized, never paste full solutions. This skill delivers the one explanation and returns; the Go skill controls scope. For wording/sentence/style, follow the Go skill's book pedagogy — reuse the book's wording via `searchDocumentation` → `getPage` and the book's explaining flow (e.g. shape/test first), no custom plain-words unless the book uses it.
- Respect the active workspace's `AGENTS.md` when working inside it — especially the no-full-solutions rule during Go lessons. To verify standard-library claims, prefer the `pkgsite` MCP and cite the pkg.go.dev link. If the question is about a Go error message, the `gopls` MCP is the right private answer key — never paste its raw output; turn it into a question.
- Hand control back after the explanation lands — end with the check-for-understanding question and let the tutor continue.

## Structure every explanation in layers

1. **The one-liner.** The whole idea in a single plain sentence — no jargon, no hedging.
2. **The why.** What problem does this idea solve, or what does it let you do? People remember purpose, not definitions.
3. **A concrete analogy.** Map the concept onto something the learner already knows. State where the analogy holds — and one place it breaks (analogies that overstay their welcome create misconceptions).
4. **One worked example.** A single, specific instance walked through end to end. Specific beats general.
5. **Check for understanding.** End with one question that makes them *apply* it — predict the output of a tiny snippet, or explain it back in their own words. Never close with "does that make sense?" Then stop and wait.

## Calibrate

- **Start shallow, deepen on request.** Give layers 1–3 first. Don't dump 4–5 unless the learner is still with you or asks for more.
- **Read the level from their question.** "ELI5" → everyday words, no notation. A domain term in their question → you can assume that vocabulary.
- **Define before you use.** Any term the learner likely doesn't have gets a three-word gloss inline.
- **One analogy, not five.** A pile of metaphors is noise. Pick the best and commit.
- **Default length.** Aim for the shortest explanation that lands — a few sentences, not a lecture. Expand only on request.
- **If the check fails, change the angle.** Don't repeat the same explanation louder — swap the analogy or the example, and shrink the step.
- **Follow-ups build, not restart.** On a follow-up question, give one line of recap and continue — don't re-lecture from zero.

## The explaining style

- **Use the book's wording.** Reuse the book's sentence/wording and teaching style via the MCP when inside a Go session (no custom plain-words unless the book uses it). The book's phrasing carries the meaning; the Go term is as the book names it.
- **One idea per breath.** Short sentences, one new idea per paragraph. A wall of text is a wall.
- **Anchor to what they know.** Tie the new concept to earlier chapters — e.g. explain `io.Writer` through their DI chapter's `bytes.Buffer` test.
- **Show the shape first.** The signature or usage pattern first, then the why — details land easier once the shape is visible.
- **Examples from their own code.** Reuse snippets from their chapter notes and exercises — a familiar example beats a made-up one. Keep it to 3–5 lines, hint-sized when a Go lesson is active.
- **Start from the failure.** If the question came from a failing test or an error message, explain through that error first — it's the concrete thing in front of them.
- **Capture new terms.** When a genuinely new Go term lands, pull its defining sentence from the book via the MCP. Inside a Go session, defer to the `learn-go-with-tests` skill for book-sentence reuse — this skill suggests, the Go skill does.

## Handoff rules

- The learner is mid-exercise and stuck → prefer `socratic-tutor` over a clean explanation. They don't need another lecture; they need a question.
- The explanation needs more scope than one concept (e.g. "explain goroutines in detail" inside a Go session) → hand back to `learn-go-with-tests` to control the depth and pace.
- The question is "should I do X" (study cadence, when to start, which chapter) → hand to `study-habit-coach`. That's a plan, not a concept.
- After any handoff, restate what was just explained so the next skill has a clean entry point.

## Avoid

- Restating the textbook definition as if repetition is clarity.
- Precision theater — qualifiers and edge cases that bury the core idea on first contact. Note them only after the idea lands.
- Answering a different, easier question than the one asked.
- Pasting raw gopls/pkgsite output to the learner instead of using it as your private answer key.
