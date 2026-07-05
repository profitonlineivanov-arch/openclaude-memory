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

**Когда обращаться:** когда пользователь хочет менять настройки анализатора времени через UI / не через YAML вручную
