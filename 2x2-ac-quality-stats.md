---
name: 2x2 AC quality stats feature — DEPLOYED 2026-05-27
description: Quality statistics for anti-candidates on /trigger page — fully deployed and working
type: project
---

Feature for 2x2 lottery dashboard `/trigger` page: generalized AC quality statistics summary. **DEPLOYED and working as of 2026-05-27.**

**What it shows:** Error rate (AC that actually appeared in draw) broken down by analyzer, by position, with Chart.js visualization.

**Implementation completed:**
- `beams_api.py` — `get_ac_quality_stats()` function (line 633)
- `dashboard_2x2.py` — import, API route `/api/ac_quality_stats`, HTML container `ac-stats-card`, JS with Chart.js
- Chart.js CDN added to `TRIGGER_HTML` `<head>` (line ~2125)
- Chart.js code wrapped in try-catch so card shows even if CDN fails
- All files uploaded to server via SCP, dashboard restarted

**Bug fixed 2026-05-27:** Chart.js CDN was missing from `TRIGGER_HTML` — caused `ReferenceError: Chart is not defined` which crashed the whole `renderACQualityStats()` function, hiding the card entirely.

**DB migration NOT yet done:** `anti_candidates_history` still lacks `reason` and `beam` columns. When migrating:
- `ALTER TABLE anti_candidates_history ADD COLUMN reason TEXT`
- `ALTER TABLE anti_candidates_history ADD COLUMN beam TEXT`
- Update `triple_beam_analyzer.py` `run_triple_beam_analysis_with_triggers()` to return 5-tuples `(num, analyzer, hash, reason, beam)` instead of 3-tuples
- Update `driver_v5.py` INSERT to store reason/beam

**Why:** User wants to see which analyzers and which TB reasons/beams produce the most AC errors, to tune the system.

**How to apply:** DB migration needed to unlock breakdown by reason/beam. Plan at `~/.openclaude/plans/witty-kindling-lantern.md`. Key files: `beams_api.py`, `dashboard_2x2.py`, `triple_beam_analyzer.py`, `driver_v5.py`.
