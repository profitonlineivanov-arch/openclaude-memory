---
name: 2x2 Triple Beam Settings Bugs Fixed
description: Два бага в настройках "Три луча" — sum_percentile=0 не отключал фильтр + деактивированные лучи работали с дефолтами (2026-05-31)
type: project
---

Исправлены два бага в настройках "Три луча" на дашборде 2x2 (2026-05-31).

**Баг 1: sum_percentile=0 не отключал фильтр редких сумм**
- В `_analyze_beam_retro()` при `sum_percentile=0` использовались 0-й и 100-й перцентили (min/max), фильтр всё равно отсекал крайние значения
- Фикс: `if block_sums and sum_percentile > 0:` в `triple_beam_analyzer.py:314`
- Теперь `sum_percentile=0` полностью отключает фильтр сумм

**Баг 2: Деактивация лучей чекбоксом не отключала луч**
- При `active=0` луч НЕ пропускался — `get_beams_data()` только исключал его из `position_overrides`, и анализатор брал дефолт из `config_v5.yaml` (`sum_percentile: 10`)
- Фикс: добавлен параметр `disabled_beams: set` в `TripleBeamAnalyzer.__init__()`, `run_triple_beam_analysis()`, `run_triple_beam_analysis_with_triggers()`
- `_analyze_position_with_fallback()` пропускает лучи из `disabled_beams` (возвращает пустые AC)
- `beams_api.py`: `get_beams_data()` и `get_beams_history()` собирают `disabled_beams` и передают в анализатор
- Проверено: pos 1 V был AC=[9,25] → стал [] при `active=0`

**Изменённые файлы:**
- `triple_beam_analyzer.py` — `disabled_beams` параметр + `sum_percentile==0` guard
- `beams_api.py` — передача `disabled_beams` во все вызовы анализа (3 штуки)

**Why:** User выставил 0 для всех позиций/лучей в графе "редкие суммы", но analyzer всё равно выдавал AC по суммам. Также чекбоксы деактивации не работали — луч продолжал работать с дефолтами.
**How to apply:** `sum_percentile=0` = "отключено". Деактивированный луч полностью пропускается. Поле ввода принимает 0 (`min="0"`).
