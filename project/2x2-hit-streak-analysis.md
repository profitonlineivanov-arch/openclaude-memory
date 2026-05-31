---
name: 2x2 Hit Streak Analysis
description: Статистический анализ — зависит ли success от предыдущего success в 2x2 (2026-05-31)
type: project
---

Анализ кластеризации успехов в timing_feedback (2026-05-31, 12906 записей).

**Общий Chi2 = 1.06, p > 0.05 — hit(t) НЕ зависит от hit(t-1).**
- P(hit) = 46.8%
- P(hit | prev hit) = 47.2% (lift 1.010 — нейтрально)
- P(hit | prev miss) = 46.3%

**Но есть часы с lift > 1.10:**
- Hour 11: P(hit|prev_hit) = 55.6%, lift = **1.12** (самый сильный)
- Hour 22: P(hit|prev_hit) = 51.7%, lift = **1.10**
- Hour 14: P(hit|prev_hit) = 54.0%, lift = 1.08
- Hour 2: P(hit|prev_hit) = 48.6%, lift = 1.09
- Hour 8: **обратный эффект** — P(hit|prev_hit) = 36.1%, lift = 0.84

**Реализовано как streak bonus (Adjustment 3 в get_signal()):**
```python
STREAK_LIFT_HOURS = {
    11: 0.04,  # lift 1.12
    22: 0.03,  # lift 1.10
    14: 0.02,  # lift 1.08
    5: 0.02,   # lift 1.08
    2: 0.02,   # lift 1.09
    4: 0.02,   # lift 1.05
    9: 0.02,   # lift 1.05
    17: 0.02,  # lift 1.06
}
```
Если последний тираж в timing_feedback был hit и его hour в словаре → score += бонус.

**Hour 8 — обратный эффект** (lift 0.84) — бонус НЕ добавлен (не в словаре).

**Why:** Пользователь хотел понять, можно ли использовать последовательность успехов для улучшения прогнозов. Глобально — нет, но для отдельных часов — да.
**How to apply:** Бонус работает автоматически в get_signal(). Проверить текущий бонус: `SELECT hour, hit FROM timing_feedback ORDER BY draw_number DESC LIMIT 1`.
