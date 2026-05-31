---
name: 2x2 Hourly Timing Analyzer
description: HourlyTimingAnalyzer в 2x2 — анализатор благоприятных часов для прогнозов, визуализация на дашборде
type: project
---

Создан HourlyTimingAnalyzer для проекта 2x2 (2026-05-29).

**Что делает**: анализирует命中率 прогнозов по часам суток и дню недели, выдаёт сигнал PLAY/WAIT.

**Файлы**:
- `/root/projects/2x2/hourly_timing_analyzer.py` — основной модуль
- `dashboard_2x2.py` — баннер + подсветка строк (API: /api/timing_signal, /api/favorable_draws, /api/favorable_periods)
- `driver_v5.py` — вызов update_stats() после каждого цикла
- `config_v5.yaml` — секция hourly_timing (порог 0.47)

**БД**: таблица `hourly_timing_stats` (rolling windows 7/30/90/all-time)

**Результаты анализа** (из 12,676 записей, 01.02-29.05.2026):
- Лучшие hour+dow (all-time): Вт 03:00 (81%), Ср 00:00 (75%), Чт 02:00 (75%), Пт 21:00 (63%)
- Худшие: Вт 13:00 (27%), Чт 07:00 (34%), Сб 18:00-19:00 (33-34%)
- Общий %命中: ~47%

**Порт дашборда**: 5000 (не 8080!)

**Документация:**
- `SPEC_hourly_timing_analyzer.md` — полная спецификация на сервере
- `README.md` — обновлён (v7.2 changelog, таблица анализаторов, API endpoints, раздел Hourly Timing)

**Метод get_favorable_periods()** — расширенная версия get_favorable_draws(), возвращает list of dicts с {draw_number, hour, dow, dow_number, hit_rate}. Используется для блочной подсветки на дашборде. С 2026-05-31: если текущий сигнал PLAY, следующий тираж (max_draw + 1) добавляется в результат с флагом `upcoming=True` — прогноз помечается благоприятным ДО публикации тиража.

**Корректировки score** (из анализа кода 2026-05-31, обновлено):
- Base score = hit_rate за **90 дней** (или best available window) — изменено с 30d для стабильности
- Adjustment 1: **21-дневный** тренд — если 21d hit_rate лучше 90d, добавляется `+trend * 0.3` (увеличено с 7d — 7 дней слишком мало для hour+dow статистики)
- Adjustment 2: streak mean reversion — после серии >= 8 проигрышей подряд добавляется `+0.03`
- Порог: score >= 0.47 → PLAY, иначе WAIT (адаптивный 0.40–0.55 через feedback)
- best_hours и next_favorable тоже используют окно 90d

**Feedback-механизм (реализован 2026-05-31):**

Таблица `timing_feedback` (12,892 записи):
- `draw_number`, `hour`, `day_of_week`, `signal` (PLAY/WAIT), `score`, `hit` (0/1), `matches`

Методы:
- `record_feedback()` — записывает feedback (идемпотентно), вызывается в driver_v5.py (шаг 9.5)
- `analyze_feedback(window_days)` — PLAY accuracy, WAIT accuracy, false_play, false_wait
- `adjust_threshold()` — корректирует play_threshold на основе accuracy за **90d**:
  - PLAY accuracy < 45% → порог +0.02, > 55% → -0.02, WAIT accuracy < 40% → -0.01
  - Границы: 0.40–0.55
- `_compute_score_for_hour(hour, dow)` — вычисляет score для конкретного hour+dow

API: `/api/timing_feedback` — возвращает feedback_90d и feedback_all (обновлено с feedback_30d).
`get_signal()` возвращает `feedback` (play_accuracy, wait_accuracy, total_feedback) и `adjusted_threshold`.
Reason строка показывает "за 90д" (не 30д).

**Метрики (2026-05-31):**
- 7d: PLAY 55.9% (322), WAIT 58.7% (351) — 673 записи
- 30d: PLAY 52.6% (1390), WAIT 58.4% (1491) — 2881 записей
- 90d: PLAY 52.1% (4064), WAIT 57.5% (4567) — 8631 записей
- All: PLAY 51.7% (6123), WAIT 57.6% (6769) — 12892 записей

**Why:** Пользователь заинтересован в feedback-механизме для корректировки сигналов — чтобы система училась на своих ошибках.
**How to apply:** При изменениях в timing analyzer — feedback-механизм уже интегрирован. Порог корректируется автоматически в памяти (не в конфиге). При добавлении новых метрик — расширять analyze_feedback().
