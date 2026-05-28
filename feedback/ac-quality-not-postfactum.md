---
name: AC quality shows real prediction data
description: When showing anti-candidate quality, use real per-prediction data from anti_candidates_history, not post-factum analysis with current ACs
type: feedback
---

When visualizing anti-candidate quality — show **real per-prediction AC failures** from `anti_candidates_history` table, not post-factum analysis.

**Why:** The original heatmap table showed post-factum data (current ACs overlaid on past draws), which the user found misleading. The user expected to see which ACs the Selector actually excluded per prediction, and whether those numbers appeared in the published draw. This is the real measure of AC quality.

**How to apply:** When building any AC quality/accuracy visualization in the 2x2 dashboard, query `anti_candidates_history` joined with `predictions_v4` to get per-prediction data. Compare AC numbers against `actual_num1..4` at the SAME position to detect failures (number excluded but appeared). Green = AC worked, red = AC failed.
