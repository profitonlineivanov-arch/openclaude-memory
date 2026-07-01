---
name: 2x2 Timing Settings Dashboard Page
description: Dashboard page /timing для просмотра и редактирования настроек HourlyTimingAnalyzer через веб-интерфейс (2026-06-30)
type: project
---

Создана страница `/timing` на дашборде 2x2 (порт 5000) для настройки HourlyTimingAnalyzer.

**Что сделано:**
- HTML-шаблон `/root/projects/2x2/templates/timing_settings.html` — карточки с параметрами и описанием на русском
- Пункт меню «Настройки времени» в навигации
- `GET /api/timing_settings` — чтение `hourly_timing` секции из `config_v5.yaml`
- `POST /api/timing_settings` — запись в `config_v5.yaml`
- Изменения применяются через `yaml.dump`, рестарт дашборда не требуется

**Параметры на странице:** play_threshold, min_predictions, windows, z_score, pseudo_count, decay_half_life, streak_mean_reversion, weekend_bonus, streak_lift_hours (таблица час→бонус), enabled

**min_predictions** (Пользователь не понял, 2026-07-01): Фильтр — час считается значимым только если total_predictions в его слоте >= min_predictions. Используется в get_signal() (проверка есть ли данные для часа) и best_hours/next_favorable (фильтрация результатов). При min=30 для 90d окна ~1 прогноз/день на час. Выше=строже, ниже=больше шума. **Вывод:** нужны тултипы/пояснения к полям формы на /timing.

**Замеченная нестыковка — ИСПРАВЛЕНО (2026-07-01):**
- `/timing` показывал `play_threshold: 0.5` (из config_v5.yaml)
- Баннер на главной показывал `adjusted_threshold: 0.47` (hardcoded default)
- **Root cause:** `__init__` не читал YAML — `cfg = config or {}`, а config=None всегда → все настройки из /timing игнорировались
- **Fix:** `_load_yaml_config()` — авто-загрузка из config_v5.yaml при config=None + `_save_config()` — сохранение скорректированного порога обратно в YAML
- Теперь `adjusted_threshold` = `play_threshold` из YAML (0.5), баннер синхронизирован с /timing

**Когда обращаться:** когда пользователь хочет менять настройки анализатора времени через UI / не через YAML вручную

**Git:** commit a644609 pushed to feature/vertical-trigger (2026-07-01). Files: hourly_timing_analyzer.py, config_v5.yaml, SPEC_hourly_timing_analyzer.md.
