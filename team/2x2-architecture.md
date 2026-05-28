---
name: 2x2 Project Architecture
description: Detailed architecture of 2x2 lottery predictor - analyzers, selector, driver, dashboard
type: project
---

## 2x2 Lottery Predictor — Architecture (v7)

### Analyzers (6 modules)
1. **triple_beam_analyzer.py** — Triple Beam retro method: 3 beams (V, DL, DR) per position, block matching (set_size=4) + sum percentile filtering (10th/90th). Returns AC by reason (pattern + sum).
2. **rarity_index.py** — RI v3 field-aware: two independent fields (Field1: A1/B1 = min/max of positions 1,2; Field2: A2/B2 = min/max of positions 3,4). Symmetric codes: 0 (frequent), ±1 (mid), ±2 (rare). RI = max(RI_field1, RI_field2), range 0-2.
3. **trigger_analyzer.py** — Trigger patterns: 3-number patterns from surrounding positions, AC = number that followed in history.
4. **diagonal_trigger_analyzer.py** — Diagonal triggers: 8 triggers (2 per position: right +1 shift, left -1 shift). Traces diagonal paths through consecutive draws. Rare but high-precision AC.
5. **morse_analyzer.py** — Disabled.
6. **temperature_features.py** + **temperature_utils.py** — Rolling hit rate, trend, volatility, z-score per number.

### Selector (horizontal_selector_v4.py)
- Weighting: base (temperature) × (1 + trend + volatility + z-score + RI bonus)
- Combination-level RI filter: reject if RI > max_combination_ri (default 3, but max RI is actually 2)
- Validation: no duplicates within pairs, pair sums 4-48, total sum 26-82, no history duplicates
- Fallback: swap pairs → change position → best RI found

### Driver (driver_v5.py / DriverV6)
Pipeline: Feedback → Trigger lifecycle → Prize update → Reverse forecast → Triple Beam analysis → **Diagonal triggers** → Temperature computation → Selector → Save prediction

### Dashboard (dashboard_2x2.py)
- Flask on port 5000, login: admin/2x2lottery
- Pages: `/` (predictions), `/beams` (beam settings), `/trigger` (combined AC visualization), `/morse`
- API: `/api/predictions`, `/api/stats`, `/api/config`, `/api/beam_settings`, `/api/beams_analysis`, `/api/beams_history`

### Config (config_v5.yaml)
- analysis_depth: 24806, triple_beam_retro: enabled, set_size: 4, sum_percentile: 10
- rarity_index: enabled, weight: 0.5, max_combination_ri: 3
- temperature_filter: enabled, window: 70
- temperature_features: enabled, alpha=0.25, beta=0.25, gamma=0.2

### Database
- `database/lottery.db` — основная БД (root-level `lottery.db` — пустой файл, не использовать!)
- Tables: draws, predictions_v4, beam_settings, anti_candidates_history, trigger_performance, trigger_life_2x2
- draws: 25,498 записей (draw_number 302850—328347), формат дат: "DD.MM.YYYY" + "HH:MM:SS" (или старый "DD.MM.YYYY HH:MM:SS" в draw_date)
- predictions_v4: 25,499 записей, ~12,822早期 записей без даты/времени (парсер не фиксировал)
