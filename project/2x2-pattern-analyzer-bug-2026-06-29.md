---
name: 2x2 Trigger AC Mismatch — Dashboard vs Database
description: Draw 331322 pos1: user sees ACs 12,16 on dashboard, but live analyzers produce 21,2 (pattern). Root cause not found — investigation cut short.
type: project
---

## Status: UNRESOLVED (investigation cut short)

User reports dashboard shows ACs **12 and 16** for position 1 of draw 331322 on "Триггерный" page, horizontal trigger tab. Live analyzers produce different values. Number 12 doesn't appear in ANY analyzer output for pos1.

## Investigation Findings (2026-06-29)

### Data Source Architecture

The `/trigger` dashboard computes ACs **in-memory** from `draws` table via:
- `TriggerAnalyzer.analyze_with_details()` (горизонтальный/pattern)
- `DiagonalTriggerAnalyzer.analyze_with_details()` (диагональный)
- `VerticalTriggerAnalyzer.analyze_with_details()` (вертикальный)

Does NOT read from `anti_candidates_history`. The history table is only used by `/api/prediction_triggers`, `/api/selector_full`, and AC quality stats.

### Live Analyzer Output for Draw 331322, Position 1

| Analyzer | ACs from live analyze_with_details() |
|---|---|
| Горизонтальный (pattern) | **[21, 2]** |
| Диагональный левый (diag_left) | [9, 20, 13] |
| Вертикальный (vertical) | [16, 17, 23, 6, 21] |

### anti_candidates_history (backfill) for same draw/pos

| Analyzer | AC stored |
|---|---|
| pattern | 21 |
| diag_left | 20 |
| vertical | 16 |
| triple_beam | 2 |

### Key Observations

1. **Number 12 never appears** in any live analyzer output for pos1 — user claim of seeing "12" on dashboard is unexplained. May be misidentified tab (possibly "Комбинированный" tab which includes TripleBeam), different draw, or a display bug.

2. **History stores only first match per analyzer** — `driver_v5.py` uses `analyze()` (stops at first match), while dashboard uses `analyze_with_details()` (finds ALL historical matches). Therefore history is a **subset** of what live analyzers produce.

3. **Backfill data is correct but incomplete** — not "phantom" as initially suspected. The live analyzer for pattern DOES produce AC=21 for pos1. But the user says dashboard shows 12 and 16, not 21.

### What Was NOT Checked

The conversation was interrupted before the user identified which specific dashboard tab/view they were referring to. Possible explanations:
- Tab mixup (user looking at "Вертикальный" or "Комбинированный" tab instead of "Горизонтальный")
- Different history_size parameter causing different trigger matches
- Data corruption in the `draws` table
- User misread (possible given mobile keyboard / fast typing context)
