---
name: 2x2 AC quality stats feature — DEPLOYED 2026-05-27
description: Quality statistics for anti-candidates on /trigger page — deployed 2026-05-27, 3 bugs fixed + AC cleanup bottleneck found 2026-05-31
type: project
---

Feature for 2x2 lottery dashboard `/trigger` page: generalized AC quality statistics summary. **DEPLOYED and working as of 2026-05-27.**

**What it shows:** Error rate (AC that actually appeared in draw) broken down by analyzer, by position, with Chart.js visualization.

**Implementation completed:**
- `beams_api.py` — `get_ac_quality_stats()` function (line ~647)
- `dashboard_2x2.py` — import, API route `/api/ac_quality_stats`, HTML container `ac-stats-card`, JS with Chart.js
- Chart.js CDN added to `TRIGGER_HTML` `<head>`
- Chart.js code wrapped in try-catch so card shows even if CDN fails

**Bugs fixed 2026-05-31:**
1. "All" button (limit=0) returned empty data — SQL `LIMIT 0` returns 0 rows. Fixed: limit=0 now means no LIMIT clause.
2. `total_draws` was misleading — showed 500 even when only ~100 draws had AC data. Fixed: added `draws_with_ac` field to response.
3. Frontend/backend field name mismatch — frontend used `d.total_draws_with_ac` but backend returned `draws_with_ac`. Fixed: aligned to `draws_with_ac`.

**Root cause — AC history cleanup in driver_v5.py:**
Every time the driver creates a new prediction, it runs a DELETE that removes all `anti_candidates_history` records except the last 100 predictions (commit `deabb01`, 2026-04-09). This caps AC data at ~100 draws regardless of how long the system runs. The code is at line ~370 in `driver_v5.py`:
```sql
DELETE FROM anti_candidates_history
WHERE prediction_id IN (
    SELECT id FROM predictions_v4
    WHERE id NOT IN (
        SELECT DISTINCT prediction_id FROM anti_candidates_history
        ORDER BY prediction_id DESC LIMIT 100
    )
)
```
User confirmed AC data should have been accumulating earlier — the cleanup was the bottleneck. **LIMIT changed from 100 to 500 on 2026-05-31** (user chose 500). Backfill script (`backfill_ac.py`) was run for 500 predictions — completed successfully. After backfill: 601 predictions with AC data (101 original + 500 backfilled). Note: backfill used current analysis state, not historical — AC candidates for old draws reflect current patterns, not what they would have been at prediction time.

**Current state (after all fixes):**
- limit=500: draws_with_ac=500/500, 3294 AC entries, 132 hits, 4.0% error rate
- limit=All: draws_with_ac=600/25757
- Triple Beam dominates AC (3278/3294 entries)
- `backfill_ac.py` saved at `/root/projects/2x2/backfill_ac.py` on server

**DB migration NOT yet done:** `anti_candidates_history` still lacks `reason` and `beam` columns. When migrating:
- `ALTER TABLE anti_candidates_history ADD COLUMN reason TEXT`
- `ALTER TABLE anti_candidates_history ADD COLUMN beam TEXT`
- Update `triple_beam_analyzer.py` `run_triple_beam_analysis_with_triggers()` to return 5-tuples `(num, analyzer, hash, reason, beam)` instead of 3-tuples
- Update `driver_v5.py` INSERT to store reason/beam

**Why:** User wants to see which analyzers and which TB reasons/beams produce the most AC errors, to tune the system.

**How to apply:** After increasing to 500, AC data will accumulate up to 500 draws. For even longer history, increase further or remove the DELETE entirely. To backfill older predictions, run `fill_missing.py` on the server. Key files: `beams_api.py`, `dashboard_2x2.py`, `driver_v5.py`.
