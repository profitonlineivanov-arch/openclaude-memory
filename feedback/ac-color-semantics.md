---
name: AC quality table color semantics
description: In 2x2 dashboard AC quality table — green vs no-color distinction: green means AC existed and worked, no-color means no AC was generated for that position
type: feedback
---

In the AC quality table on `/trigger` page, the difference between **green** and **no-color** is non-obvious and must be explained clearly to the user:

- **Зелёный (green)** — система **исключила какие-то числа** (AC > 0), и выпавшее число **не попало** в список исключений. AC отработали корректно.
- **Без цвета** — система **не исключила ни одного числа** для этой позиции (AC = 0). Триггеры не сработали, предсказания не было.
- **Красный с `!`** — провал AC: число было в списке исключений, но выпало.

**Why:** User explicitly asked "чем отличается зелёный от без цвета?" — the distinction (prediction existed and succeeded vs. no prediction at all) is not intuitive from the UI alone.

**Completeness:** Table covers ALL analyzers, not just triggers. `get_ac_quality_history` reads from `anti_candidates_history` table which stores AC from all sources (triple_beam, trigger, morse, diagonal_trigger), grouped by `analyzer_name`. User initially assumed it was trigger-only — important to clarify this when explaining the table.

**Per-analyzer breakdown (2026-05-26):** Each position cell now shows mini-badges below the number: `TB:5`, `Tr:3`, `DT:2`, `Mo:4`. Green badge = analyzer's AC worked, red badge with `!` = analyzer's AC failed. Lets user compare which analyzer source produces better anti-candidates.

**How to apply:** When documenting or explaining the AC quality table, always clarify the three cell states AND note that all analyzers are represented with per-analyzer badges. When designing similar visualizations, make the "no data" vs "success" states visually distinct enough to avoid confusion.
