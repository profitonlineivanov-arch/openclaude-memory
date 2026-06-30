---
name: 2x2 AC Quality Trigger Fix 2026-06-30
description: Fixed missing trigger ACs in anti_candidates_history - driver_v5.py read wrong config key
type: project
---

AC quality section on /trigger was broken: no color markers, no trigger analyzer data.

**Root cause:** driver_v5.py line 420 read `config.analysis.history_size` (key doesn't exist → default 200), but real config is `trigger.history_size: 20093`. With 200-draw window, Pattern/Diagonal/Vertical analyzers found zero matches (triggers are 10000+ draws deep), so they saved no ACs.

**Fix applied 2026-06-30:**
1. driver_v5.py line 420: changed `self.config.get("analysis", {}).get("history_size", 200)` → `self.config.get("trigger", {}).get("history_size", 20000)`
2. Backfilled 49 predictions (331356-331404) with trigger ACs via backfill_trigger_acs.py

**Result:** 1415 AC entries in last 50 draws, 58 hits, 4.1% error rate across all 5 analyzers (pattern, diag_left, diag_right, vertical, triple_beam).
