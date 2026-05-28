---
name: AC quality per-analyzer breakdown
description: AC quality table on /trigger page now shows per-analyzer badges (TB/Tr/DT/Mo) with hit/miss status
type: project
---

## Разбивка AC по анализаторам — реализовано (26 мая 2026)

Коммит: `88cc6b2` на ветке V7.

**Что сделано:**
- `beams_api.py` — `get_ac_quality_history` возвращает `analyzer_details` для каждой позиции: `{name: {count, hit, hit_nums}}`
- `dashboard_2x2.py` — CSS (`.az`, `.az-badge`, `.az-ok`, `.az-fail`) + обновлён `renderACQuality()` с mini-бейджами
- Легенда обновлена, добавлен пример бейджа `TB:5`

**Визуал:** под номером позиции — бейджи `TB:5` `Tr:3` `DT:2` `Mo:4`:
  - Зелёный = AC не попал в результат (анализатор корректно исключил)
  - Красный с `!` = провал (анализатор ошибся)
  - Tooltip при наведении — детали (какие числа провалились)

**Why:** позволяет оценить, какой источник AC даёт лучшие анти-кандидаты.
