---
name: Selector iteration analysis uses full selector pipeline
description: User corrected: iteration analysis must use full selector pipeline with all filters, not simplified version
type: feedback
---

**Правило:** При анализе итераций Селектора использовать ПОЛНЫЙ пайплайн со всеми фильтрами (Triple Beam, Triggers, Diagonal Triggers, RI filter, суммы), а не упрощенную версию или случайный выбор.

**Why:** Пользователь напрямую отверг упрощенную логику с температурами и роботогенными решениями. Ты пытался "упростить" анализ, убрав температуры и часть логики, но пользователь потребовал использовать "весь набор фильтров Селектора".

**Как применять:**
- При симуляции Селектора не отключать фильтрацию (Triple Beam, RI, суммы и т.д.)
- Не заменять реальный Селектор на случайный выбор или упрощенную версию
- Использовать `HorizontalSelector` со всеми его методами и фильтрами
- В `IterationTrackingSelector.extend(HorizontalSelector)` не отключать `temp_filter_enabled` и не отменять логику валидации

**Пример неправильного подхода (НЕЛЬЗЯ):**
```python
self.temp_filter_enabled = False  # Убрана температура — НЕПРАВИЛЬНО
```

**Правильно:**
```python
super().__init__(anti_candidates, config, db_path, temperatures, temp_features)  # Полный пайплайн
```