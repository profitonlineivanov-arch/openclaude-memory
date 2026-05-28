---
name: Quality stats progress — /trigger page
description: AC quality stats summary deployed, DB migration for reason/beam still pending
type: project
---

**DONE (2026-05-27):**
1. `get_ac_quality_stats(limit)` in `beams_api.py` (line 633)
2. API route `/api/ac_quality_stats` in `dashboard_2x2.py`
3. UI in `TRIGGER_HTML` — card `ac-stats-card`, tables analyzers/positions/hits, Chart.js
4. Chart.js CDN added + try-catch wrapper (fixed initial deployment bug)

**KNOWN FRAGILITY:** `loadAll()` uses `Promise.all` for 5 API calls. If ANY fails, the entire function goes to catch and `renderACQualityStats()` never runs. Consider making AC stats load independently or with its own error boundary.

**DEBUGGING (2026-05-27 evening):** User reports data not loading on /trigger. API works from curl. Added console.log debug statements to trace where execution stops. User is on mobile (Android/Termux) — can't easily access browser DevTools console.

**TODO — DB migration for reason/beam breakdown:**
- `ALTER TABLE anti_candidates_history ADD COLUMN reason TEXT`
- `ALTER TABLE anti_candidates_history ADD COLUMN beam TEXT`
- Update `triple_beam_analyzer.py` → 5-tuples `(num, analyzer, hash, reason, beam)`
- Update `driver_v5.py` INSERT

**Why:** User wants granular stats by TB reason (pattern vs sum) and beam (V/DL/DR) to tune the system.
**How to apply:** Plan at `~/.openclaude/plans/witty-kindling-lantern.md`. Run migration first, then update analyzer and driver.
