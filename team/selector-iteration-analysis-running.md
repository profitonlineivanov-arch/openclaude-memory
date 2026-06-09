---
name: Selector Iteration Analysis (no-RI run) — ЗАВЕРШЕНО
description: 10k no-RI run finished 2026-06-08 13:05. Results: 1+/2+/3+/4 = 100%/100%/63.2%/2.6%. RI proven non-load-bearing.
type: project
---

## Selector Iteration Analysis — 10k run WITHOUT RI (2026-06-08)

**Status:** ✅ COMPLETED at 2026-06-08 13:05. Final stats:
- 1+ matches: 10000 (100.0%)
- 2+ matches: 9999 (100.0%)
- 3+ matches: 6317 (63.2%)
- 4 matches: 264 (2.6%)
- avg runs: 1=2.8, 2=33.3, 3=296.9, 4=458.5

**Comparison vs WITH RI run (also 10k):**
| Match | With RI | Without RI | Δ |
|-------|---------|------------|---|
| 3+ | 61.5% | 63.2% | +1.7% without RI |
| 4 | 2.7% | 2.6% | −0.1% |

**Conclusion:** RI is not load-bearing — disabling it does not hurt match quality (no-RI is marginally better within noise).

**Command (was):**
```bash
nohup /root/projects/2x2/venv/bin/python3 -u selector_iteration_analyzer.py \
  --limit 10000 --max-runs 1000 --no-ri \
  --output selector_iterations_10k_no_ri.csv \
  > selector_iteration_10k_no_ri.log 2>&1 &
```

**Files (final):**
- `/root/projects/2x2/selector_iteration_analyzer.py` — patched with --no-ri support
- `/root/projects/2x2/selector_iteration_10k_no_ri.log` (7.4 KB) — completed log
- `/root/projects/2x2/selector_iterations_10k_no_ri.csv` (508 KB) — final results

**See also:**
- `project/selector-iteration-reverse-engineering.md` — full experiment writeup with results table
- `team/2x2-selector-iteration-analysis.md` — sister analysis doc
