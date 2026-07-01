---
name: Timing Feedback Mechanism
description: feedback-цикл для HourlyTimingAnalyzer — отслеживает PLAY/WAIT accuracy и корректирует порог (2026-05-31)
type: project
---

Реализован feedback-механизм для HourlyTimingAnalyzer (2026-05-31).

**Что добавлено:**
- Таблица `timing_feedback` — лог каждого тиража: signal (PLAY/WAIT), score, hit, matches
- `record_feedback()` — записывает feedback для новых тиражей (идемпотентно)
- `analyze_feedback(window_days)` — считает PLAY/WAIT accuracy, false_play, false_wait
- `adjust_threshold()` — корректирует play_threshold на основе accuracy за **90d** (увеличено с 30d для стабильности):
  - PLAY accuracy < 45% → +0.02 (сигналов слишком много ложных)
  - PLAY accuracy > 55% → -0.02 (можно смягчить)
  - WAIT accuracy < 40% → -0.01 (слишком много WAIT)
  - Границы: 0.40–0.55
- `get_signal()` возвращает feedback accuracy + adjusted_threshold
- Окна в get_signal(): **90d** (базовый score), **21d** (тренд: если 21d > 90d → +trend×0.3), **all-time** (fallback). Streak mean reversion: +0.03 при серии проигрышей ≥ 8.
- Следующий тираж помечается как благоприятный ДО публикации если сигнал PLAY (upcoming=True)

**Бэкофилл:** 12891 записей.

**Метрики по окнам (2026-05-31):**
- 7d: PLAY 55.9% (322), WAIT 58.7% (351) — 673 записей
- 30d: PLAY 52.6% (1390), WAIT 58.4% (1491) — 2881 записей
- 90d: PLAY 52.1% (4064), WAIT 57.5% (4567) — 8631 записей
- All: PLAY 51.7% (6123), WAIT 57.6% (6769) — 12892 записей

**Пороги (2026-05-31, уточнение 2026-07-01):**
- `play_threshold=0.5` в config_v5.yaml (повышен с 0.47 после тестов)
- `adjust_threshold()` через feedback корректирует `self.play_threshold` и сохраняет обратно в YAML через `_save_config()` (добавлено 2026-07-01)
- Границы корректировки feedback (0.40–0.55)
- **Важно:** до 2026-07-01 `adjust_threshold()` менял порог только в памяти — настройки из config_v5.yaml не загружались, значения сбрасывались при каждом рестарте

**Из чего формируется score (порядок приоритета):**
1. Базовый = hit_rate из hourly_timing_stats (90d, hour+day_of_week, fallback на hour aggregate, потом all-time)
2. +21d trend: если 21d hit_rate лучше 90d → +trend×0.3
3. +Streak mean reversion: если серия проигрышей ≥ 8 → +0.03
4. +Streak bonus (Adjustment 3): если предыдущий тираж hit в часе с lift > 1.05 → +0.02–0.04 (часы: 11→0.04, 22→0.03, 14/5/2/4/9/17→0.02)
5. Feedback-корректировка порога (не score, а play_threshold): PLAY acc <45% → +0.02, >55% → -0.02, WAIT acc <40% → -0.01

**Не учитывается:**
- Количество совпадений (1/4 и 4/4 = одинаковый hit)
- Размер выигрыша/проигрыша
- Динамические паттерны по дням недели (только статический hit_rate) — частично учтено через 21d trend
- Корреляция между часами

**Файлы:** hourly_timing_analyzer.py, driver_v5.py (record_feedback вызов), dashboard_2x2.py (/api/timing_feedback)

**Deployed:** 2026-05-31, commit 1b7dc50 on branch V8, pushed to GitHub profitonlineivanov-arch/2x2.git

**Why:** Ранее не было обратной связи — сигнал PLAY/WAIT не проверялся against реальность. Окно увеличено до 90d для более стабильной корректировки (8631 vs 2881 записей).
**How to apply:** Метрики доступны через /api/timing_feedback. Порог адаптируется автоматически при каждом get_signal(). Для изменений окна — два вызова analyze_feedback(window_days=) в get_signal() и adjust_threshold().
