---
name: Diagonal triggers vs diagonal beams
description: In 2x2 project, diagonal triggers (diagonal_trigger_analyzer.py) and diagonal beams (triple_beam_analyzer.py) are different analyzers — never confuse them
type: feedback
---

When working on the 2x2 project, do NOT confuse diagonal triggers with diagonal beams. They are separate analyzers with similar names.

- **Diagonal triggers** (`diagonal_trigger_analyzer.py`) — 3 positions from 3 consecutive draws with position shift ±1. Shows on `/trigger` page. Cause labels: `diag_right`, `diag_left`.
- **Diagonal beams** (`triple_beam_analyzer.py`) — part of the Triple Beam analyzer, a block-based retro method. Shows on `/beams` page. Completely separate system.

**Why:** User explicitly warned about this confusion (2026-05-25). The names are similar but the analyzers are architecturally different and serve different purposes. Mixing them up would corrupt the wrong page or analyzer.

**How to apply:** When a task mentions "диагональные" (diagonal), always clarify which analyzer is meant. Check the file name and the page route to confirm. The trigger page is `/trigger`, the beams page is `/beams` — they don't share code.
