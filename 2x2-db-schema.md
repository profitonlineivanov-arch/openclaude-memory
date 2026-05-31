---
name: 2x2 lottery project key column and table names
description: Database uses draw_number (not draw_id) and predictions_v4 (not predictions) — gotcha when querying
type: project
---

The 2x2 lottery predictor project at `/root/projects/2x2` on server 45.146.164.144 has non-obvious database schema naming:

- `draws` table primary key is `draw_number` (not `draw_id`) — INTEGER, autoincrement
- Predictions table is `predictions_v4` (not `predictions`) — evolved through versions
- Other tables: `beam_settings`, `anti_candidates_history`, `trigger_performance`, `trigger_life_2x2`, `hourly_timing_stats`, `timing_feedback`

**DB file location gotcha:** `/root/projects/2x2/lottery.db` is 0 bytes (empty/placeholder). The REAL database is at `/root/projects/2x2/database/lottery.db` (~10MB). Always use `database/lottery.db`.

**`draws` table columns:** `draw_number` (INTEGER PK), `num1`-`num4` (INTEGER), `draw_date` (TEXT, dd.mm.yyyy), `draw_time` (TEXT, HH:MM), `created_at` (TEXT, ISO datetime). No `timestamp` column — use `created_at` or `draw_date`/`draw_time` instead.

**`anti_candidates_history` schema (as of 2026-05-27):**
- Columns: `id`, `prediction_id`, `position`, `number`, `analyzer_name`, `trigger_hash`, `created_at`
- **Missing columns (planned):** `reason` and `beam` — not yet in DB, migration needed
- `analyzer_name` values in production: `triple_beam` (438 rows), `diag_left` (18), `diag_right` (15)
- **Not stored:** horizontal `trigger` and `morse` analyzers don't write to this table
- `trigger_hash` is NULL for all triple_beam entries — beam (V/DL/DR) cannot be distinguished
- Triple Beam has two AC reasons: `pattern` (block match) and `sum` (rare sum) — currently not persisted in DB

**Why:** Assumed `draw_id` based on code patterns — caused sqlite3 OperationalError. Table name `predictions_v4` reflects version evolution.

**How to apply:** When writing queries or scripts for the 2x2 database, use `draw_number` for joins and ordering on draws table, and `predictions_v4` for prediction queries. Always verify column names with `PRAGMA table_info()` first. When working with anti_candidates_history, note that reason/beam are not yet stored — need migration before quality stats by beam/reason.
