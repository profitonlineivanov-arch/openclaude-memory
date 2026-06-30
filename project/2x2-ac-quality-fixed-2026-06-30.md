---
name: 2x2 AC Quality Trigger Fix 2026-06-30
description: Two bugs fixed — wrong config key AND driver calls analyze() not analyze_with_details()
type: project
---

AC quality section on /trigger was broken in two distinct ways.

## Bug 1: Wrong config key (fixed earlier)

**Root cause:** driver_v5.py line 420 read `config.analysis.history_size` (key doesn't exist → default 200), but real config is `trigger.history_size: 20093`. With 200-draw window, Pattern/Diagonal/Vertical analyzers found zero matches (triggers are 10000+ draws deep), so they saved no ACs.

**Fix:** Changed to `self.config.get("trigger", {}).get("history_size", 20000)`. Applied 2026-06-30 07:18.

**Backfill:** 49 predictions (331356-331404) backfilled via backfill_trigger_acs.py. Result: 1415 AC entries in last 50 draws, 58 hits, 4.1% error rate.

## Bug 2: Driver calls analyze() not analyze_with_details() (count=1 everywhere)

**Root cause:** driver_v5.py called `ta.analyze(draws)`, `dta.analyze(draws)`, `vta.analyze(draws)` — all three `analyze()` methods stop at the **first** match per position:

- `TriggerAnalyzer.analyze()` — has `if target_pos in found_positions: continue` (once position "found", skip rest)
- `DiagonalTriggerAnalyzer.analyze()` — has `break  # first match only per direction per position`
- `VerticalTriggerAnalyzer.analyze()` — has `break # first match only`

Each analyzer returns exactly 1 AC per position per analyzer regardless of history size.

Meanwhile, `analyze_with_details()` (used by backfill_trigger_acs.py) returns ALL matches — explaining why backfilled draws showed correct multiple ACs but live predictions showed count=1.

**Fix applied 2026-06-30:** 7 changes in driver_v5.py:
1. `ta.analyze(draws)` → `ta.analyze_with_details(draws)`
2. `dta.analyze(draws)` → `dta.analyze_with_details(draws)`
3. `vta.analyze(draws)` → `vta.analyze_with_details(draws)`
4-6. Iteration changed from `.get(pos, [])` → `.get(pos, {}).get('acs', [])` for all three
7. Log line fixed for new dict return format

## Status

- Draw 331405 still has no trigger ACs (user declined backfill)
- All draws 331387-331409 (up to 08:14) created **before** second fix — confirmed count=1 everywhere
- Draw 331408: created 04:59 (before fix), confirmed 14 ACs all count=1 except P4 triple_beam=2
- Second fix applied ~13:00 — no driver runs after that point (last draw 331409 at 08:14, driver not restarted)
- No post-second-fix predictions exist yet — fix will activate on next parser/driver run when new API draw arrives
- Once new draw arrives, trigger AC counts will show multi-match values
