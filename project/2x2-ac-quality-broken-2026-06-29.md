---
name: 2x2 AC Quality Broken — Real Root Cause Found 2026-06-30
description: driver_v5.py reads wrong config key for history_size → trigger analyzers use LIMIT 200 instead of 20093 → no trigger ACs saved. Fix applied 2026-06-30.
type: project
---

## Issue

AC quality section on `/trigger` dashboard shows only triple_beam data. Trigger analyzers (pattern, diag_left, diag_right, vertical) produce almost no ACs in `anti_candidates_history`.

Last 20 predictions AC sources (2026-06-30):
- triple_beam: 20/20
- vertical: 2/20
- pattern: 1/20
- diag_left: 0/20
- diag_right: 0/20

## Real Root Cause (2026-06-30)

**Config key mismatch.** In `config_v5.yaml`, the correct setting is `trigger.history_size: 20093`. But `driver_v5.py` line 420 reads:

```python
self.config.get("analysis", {}).get("history_size", 200)
```

Key `analysis.history_size` doesn't exist -> default 200. Trigger analyzers search only the last 200 draws, but historical trigger matches are typically 10000+ draws deep. With LIMIT 200, analyzers find nothing -> no trigger ACs saved.

This is the **real** reason the AC quality table is broken for trigger analyzers. The 2026-06-29 fix (adding trigger analyzer imports + INSERT logic) was structurally correct but ineffective because the data-fetch step used wrong history size.

## Fix Applied 2026-06-30

Changed line 420 in `driver_v5.py`:
```python
# Before:
self.config.get("analysis", {}).get("history_size", 200)
# After:
self.config.get("trigger", {}).get("history_size", 20000)
```

Now reads `trigger.history_size: 20093` from config.

## Still Unresolved

1. ~~**No backfill for last ~50 predictions**~~ **DONE 2026-06-30** — 49 predictions backfilled (331356-331404). Backfill script `backfill_trigger_acs.py` reran TriggerAnalyzer/Diagonal/Vertical with full draw history for each prediction and inserted all unique ACs into `anti_candidates_history`.
2. **User saw "12 and 16" on dashboard for draw 331322** — unexplained. Live analyzers never produce 12 for pos1. May be user misread of dashboard tab.
3. The fix applies to NEW predictions going forward. Backfill covers the gap.

## Post-Backfill Stats (2026-06-30)

After fix + 49-prediction backfill, AC quality for last 50 draws:

| Analyzer | AC Entries | Hits | Error Rate |
|---|---|---|---|
| pattern | 300 | 13 | 4.3% |
| diag_left | 278 | 7 | 2.5% |
| diag_right | 308 | 13 | 4.2% |
| vertical | 302 | 15 | 5.0% |
| triple_beam | 227 | 10 | 4.4% |
| **Total** | **1415** | **58** | **4.1%** |

All trigger analyzers now populate AC quality table with green/red markers.

## Data Source Map

| UI Component | Data Source |
|---|---|
| `/trigger` main display | `draws` table -> in-memory TriggerAnalyzer/Diagonal/Vertical (live computation) |
| `/api/prediction_triggers` | `anti_candidates_history` (SQL query) |
| `/api/selector_full` | `anti_candidates_history` (last prediction) |
| `/api/anti_candidates` | `trigger_life_2x2` table |
| AC Quality History/Stats | `anti_candidates_history` |
