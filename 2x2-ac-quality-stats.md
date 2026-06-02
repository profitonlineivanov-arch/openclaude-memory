---
name: 2x2 AC quality stats feature — DEPLOYED 2026-05-27
description: Quality statistics for anti-candidates — on BOTH /trigger and /beams pages. Deployed 2026-05-27, 3 bugs fixed + AC cleanup bottleneck.
type: project
---

Feature for 2x2 lottery dashboard: generalized AC quality statistics summary. **DEPLOYED 2026-05-27.**

**What it shows:** Error rate (AC that actually appeared in draw) broken down by analyzer, by position, with Chart.js visualization.

**Implementation:**
- `beams_api.py` — `get_ac_quality_stats()` function (line ~647)
- `dashboard_2x2.py` — import, API route `/api/ac_quality_stats`, HTML container `ac-stats-card`, JS with Chart.js
- Chart.js CDN added to `TRIGGER_HTML` and `BEAMS_HTML` `<head>`
- Chart.js code wrapped in try-catch so card shows even if CDN fails

**Bugs fixed 2026-05-31:**
1. "All" button (limit=0) returned empty data — SQL `LIMIT 0` returns 0 rows. Fixed: limit=0 now means no LIMIT clause.
2. `total_draws` was misleading — showed 500 even when only ~100 draws had AC data. Fixed: added `draws_with_ac` field to response.
3. Frontend/backend field name mismatch — frontend used `d.total_draws_with_ac` but backend returned `draws_with_ac`. Fixed: aligned to `draws_with_ac`.

**Root cause — AC history cleanup in driver_v5.py:**
Every time the driver creates a new prediction, it runs a DELETE that removes all `anti_candidates_history` records except the last N predictions. LIMIT changed from 100 to 500 on 2026-05-31 (user chose 500). After backfill: 601 predictions with AC data.

**ВАЖНО (2026-06-01 CORRECTED):** AC stats находится на ОБЕИХ страницах — /trigger И /beams. НЕ переносить и НЕ удалять с /trigger!

**Current state:**
- limit=500: draws_with_ac=500/500, 3294 AC entries, 132 hits, 4.0% error rate
- Triple Beam dominates AC (3278/3294 entries)
- `backfill_ac.py` saved at `/root/projects/2x2/backfill_ac.py` on server

**DB migration NOT yet done:** `anti_candidates_history` still lacks `reason` and `beam` columns.

**Why:** User wants to see which analyzers and which TB reasons/beams produce the most AC errors, to tune the system.

**How to apply:** Key files: `beams_api.py`, `dashboard_2x2.py`, `driver_v5.py`. AC stats на обеих страницах — не трогать без явного указания.
