---
name: Simulations must use real system pipeline
description: User rejects simplified/random simulations — must use actual analyzers, filters, and full pipeline for any Selector testing
type: feedback
---

При тестировании Селектора использовать реальный пайплайн, а не упрощённые модели.

**Why:** Влад отклонил симуляцию с随机ным выбором и 1 AC на позицию: "Селектор не ищет тёплых комбинаций и анти-кандидатов по одному — это не является правильным исключением." Упрощённая модель не отражает реальное поведение системы с анализаторами (Triple Beam, диагональные триггеры), фильтрами температуры, RI и валидацией.

**How to apply:** Любая симуляция/тестирование 2x2 должна:
1. Запускать `run_triple_beam_analysis()` с `cutoff_draw_number` для исторических тиражей
2. Вычислять реальные температуры и features
3. Создавать `HorizontalSelector` с полными данными
4. Вызывать `selector.generate_prediction(return_meta=True)`

Не использовать随机ный выбор с весами как замену реальному Селектору.
