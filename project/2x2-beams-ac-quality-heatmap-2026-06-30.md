---
name: 2x2 Beams AC Quality Heatmap 2026-06-30
description: AC quality heatmap added to /beams page — color markers, badges, legend
type: project
---

AC quality heatmap added to /beams page on 2026-06-30, matching trigger page style.

## What was added

**Heatmap card** (between AC stats card and forecast card):
- Title: «Качество анти-кандидатов (последние 20 прогнозов) — Три луча»
- Legend: green (AC worked), red (AC failure), ser (no AC)
- Table: draw number × 4 positions, color-coded cells
- Badges per cell: «Лучи:N» with tooltip showing analyzer name, AC count, and hit numbers
- Data source: `/api/ac_quality_history?limit=20&analyzer=triple_beam`
- Analyzer_details for triple_beam: count, hit (bool), hit_nums (array)

**CSS classes added:**
- `.ac-red` — red background for AC failures
- `.free-green` — green background for AC working
- `.az-badge`, `.az-tb` — badge styling (green background)
- `.az` — flex container for badges
- `.legend`, `.legend-item`, `.legend-color` — legend styling

**JS function:** `renderACQuality()` — fetches data, renders per-draw rows with color-coded position cells and analyzer badges. Called on DOMContentLoaded.

## Documentation update

SPEC_dashboard_2x2.md updated with:
- Section 4.6 expanded (AC quality heatmap + stats on /beams)
- New sections 4.11 (`/api/ac_quality_history`) and 4.12 (`/api/ac_quality_stats`)
- New `anti_candidates_history` table in DB section
- Changelog entry 30.06.2026
- Branch name updated to `feature/vertical-trigger`

## Git

Commit `3f68776` pushed to `origin/feature/vertical-trigger`:
```
feat: AC quality heatmap on /beams page (triple_beam analyzer)
```

Files: `dashboard_2x2.py`, `SPEC_dashboard_2x2.md`, `config_v5.yaml` (3 files, +171/-7 lines).

## Implementation note

Patched via Python script encoded as base64, decoded and run on server (because heredoc and Write tool both failed due to quoting/escaping issues with innerHTML in the template content). SPEC updated via same base64+scp method.
