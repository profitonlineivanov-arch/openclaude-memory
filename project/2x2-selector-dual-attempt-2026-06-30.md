---
name: 2x2 Selector Dual Attempt
description: configurable selector_attempts (default 2), generate_prediction() вызывается N раз, последний сохраняется (2026-06-30)
type: project
---

Количество попыток селектора в `driver_v5.py` теперь настраивается через `config_v5.yaml` → `selection.selector_attempts` (по умолчанию 2).

Логика:
- `attempts_total = self.config.get('selection', {}).get('selector_attempts', 2)`
- Цикл: N-1 вызовов `selector.generate_prediction()` отбрасываются
- Последний вызов с `return_meta=True` сохраняется как прогноз
- `attempts = meta.get('attempts', 0) + (attempts_total - 1)` — учитывает отброшенные

**Поле на дашборде:** Страница селектора, раздел температуры, поле «Попыток селектора» (1–20), сохраняется в `config_v5.yaml` через API.

**Поправка 2026-06-30:** attempts в БД теперь `+ attempts_total - 1` вместо прежнего `+1`, учитывает количество отброшенных.
