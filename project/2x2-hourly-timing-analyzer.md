---
name: 2x2 Hourly Timing Analyzer
description: HourlyTimingAnalyzer в 2x2 — анализатор благоприятных часов для прогнозов, визуализация на дашборде
type: project
---

Создан HourlyTimingAnalyzer для проекта 2x2 (2026-05-29).

**Что делает**: анализирует命中率 прогнозов по часам суток и дню недели, выдаёт сигнал PLAY/WAIT.

**Файлы**:
- `/root/projects/2x2/hourly_timing_analyzer.py` — основной модуль
- `dashboard_2x2.py` — баннер + подсветка строк (API: /api/timing_signal, /api/favorable_draws)
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

**Why:** Пользователь хочет видеть когда лучше входить в игру визуально на дашборде.
**How to apply:** При изменениях в 2x2 учитывать что timing analyzer — отдельный модуль, не produces anti-candidates.
