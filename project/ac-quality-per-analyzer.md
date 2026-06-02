---
name: AC quality per-analyzer breakdown
description: AC quality table with per-analyzer badges (TB/Tr/DT/Mo) — on BOTH /trigger and /beams pages (NOT moved, 2026-06-01 CORRECTED)
type: project
---

## Разбивка AC по анализаторам — реализовано (26 мая 2026)

Коммит: `88cc6b2` на ветке V7.

**Что сделано:**
- `beams_api.py` — `get_ac_quality_history` возвращает `analyzer_details` для каждой позиции: `{name: {count, hit, hit_nums}}`
- `dashboard_2x2.py` — CSS (`.az`, `.az-badge`, `.az-ok`, `.az-fail`) + обновлён `renderACQuality()` с mini-бейджами
- Легенда обновлена, добавлен пример бейджа `TB:5`

**Расшифровка сокращений** (из `dashboard_2x2.py`):
- **TB** = Triple Beam (Тройной луч) — основной анализатор
- **Tr** = Trigger (Триггерный)
- **DT** = Diagonal Trigger (Диагональный триггер)
- **Mo** = Morse (Морзе)
- **DL** = Diagonal Left (Левый диагональный)
- **DR** = Diagonal Right (Правый диагональный)

**Визуал:** под номером позиции — бейджи `TB:5` `Tr:3` `DT:2` `Mo:4`:
  - Зелёный = AC не попал в результат (анализатор корректно исключил)
  - Красный с `!` = провал (анализатор ошибся)
  - Tooltip при наведении — детали (какие числа провалились)

**ВАЖНО (2026-06-01):** Таблица AC quality с бейджами TB/Tr/DT/Mo на /trigger — все анализаторы. На /beams — AC stats только для Triple Beam (фильтр `?analyzer=triple_beam`), без таблицы "По анализаторам", график по позициям. НЕ удалять AC quality с /trigger!

**Why:** позволяет оценить, какой источник AC даёт лучшие анти-кандидаты. Нужно на обеих страницах для удобства.
