---
name: 2x2 Dashboard Page Reorganization
description: /beams page restyled in trigger style + AC stats filtered to triple_beam only. AC quality on /trigger shows all analyzers. (2026-06-01)
type: project
---

Разделение контента между страницами /trigger и /beams на дашборде 2x2.

**Задача (2026-06-01):**
1. Страницу /beams оформить в стиле /trigger (CSS-переменные, .card layout, sticky nav)
2. На /beams добавить Статистика качества AC — только для анализатора Triple Beam
3. AC quality таблица и статистика ВСЕХ анализаторов ОСТАЮТСЯ на /trigger

**ВАЖНО (урок 2026-06-01):**
Первоначально было сделано неправильно — AC quality секции были УДАЛЕНЫ из /trigger. Пользователь потребовал вернуть обратно. Всё восстановлено.

**API — параметр analyzer (2026-06-01):**
- `get_ac_quality_stats(limit, analyzer=None)` и `get_ac_quality_history(limit, analyzer=None)` — фильтр по `analyzer_name` в SQL
- `/api/ac_quality_stats?limit=50&analyzer=triple_beam` — только TB данные
- `/api/ac_quality_stats?limit=50` — все анализаторы (по умолчанию)
- `/api/ac_quality_history?limit=20&analyzer=triple_beam` — история только TB

**Что на /beams (triple_beam only):**
- fetch с `?analyzer=triple_beam`
- Заголовок: "Статистика качества AC — Три луча"
- Карточки: "Всего AC (TB)" вместо "Всего AC"
- Таблица: только по позициям (без "По анализаторам" — не нужна, всё и так TB)
- График: Error Rate по позициям (не по анализаторам)
- Таблица провалов: без колонки "Анализатор"

**Что на /trigger (все анализаторы):**
- AC quality таблица с TB/Tr/DT/Mo бейджами + Легенда
- Статистика AC с кнопками 50/100/500/All
- Таблицы по анализаторам И по позициям
- Chart.js график Error Rate по анализаторам

**Файлы:**
- `beams_api.py` — `get_ac_quality_history(limit, analyzer)`, `get_ac_quality_stats(limit, analyzer)`
- `dashboard_2x2.py` — TRIGGER_HTML, BEAMS_HTML, API routes с `?analyzer=...`

**Why:** Пользователю нравится стиль триггерной страницы. На /beams нужна статистика только от Triple Beam, т.к. это страница "Три луча". На /trigger — общая статистика по всем анализаторам.

**How to apply:** При изменениях dashboard — НЕ удалять контент со страниц без явного подтверждения. Всегда показывать план перед изменениями. API `/api/ac_quality_stats` поддерживает фильтр `?analyzer=...`.
