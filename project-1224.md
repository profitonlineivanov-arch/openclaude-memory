---
name: 1224 Project
description: Lottery "Всё или ничего" (12 из 24) prediction system with anti-candidate strategy, dual-matrix selector, feedback loop. Local: C:\Users\admin\Downloads\лото\1224\, remote: /root/projects/1224/.
type: project
---

Система прогнозирования лотереи "Всё или ничего" (Столото): 12 чисел из 24.
- **Локальный путь:** `C:\Users\admin\Downloads\лото\1224\`
- **Сервер:** `ssh root@45.146.164.144` → `/root/projects/1224/`

**Ключевая особенность:** Выигрыш за 0 ИЛИ 12 совпадений. Система прогнозирует 12 **анти-кандидатов** — числа, которые НЕ выпадут. Цель — минимизировать совпадения.

**Архитектура (V5/V6):**
- `universal_analyzer_v6.py` — хаотичные триггеры (A2-A11), 10 анализаторов с разными offset
- `selector_v5.py` — финальный отбор 12 анти-кандидатов (голосование + трёхуровневая оценка)
- `arbiter_v5.py` — обратная связь, репутация триггеров
- `orchestrator_v5.py` — координация pipeline
- `config_v5.yaml` — конфигурация, `analysis_depth: 11884`
- Дашборд: `unified_dashboard.py` на Flask, порт 5555

**Локальная версия (offset pipeline)** — более продвинутая архитектура:
- `asymmetric_trigger_analyzer_v2.py` — триггеры с динамическим размером (5 позиций → растёт/сужается до 1-3 AC на позицию)
- `offset_selector_v2.py` — **двойная матрица** (statistical + correction), комбинаторный выбор C(20,12)
- `feedback_engine.py` — матрица коррекции из ошибок прогнозов (обратная связь)
- `forecast_orchestrator_offset_v4.py` — основной пайплайн с feedback loop
- `parser_1224.py` — Selenium-скрейпер с stoloto.ru
- `sheets_client.py` / `sheets_client_with_colors.py` — запись в Google Sheets

**Двойная матрица (ключевое отличие от 2x2):**
1. **Statistical Matrix (12×12)** — из всего архива: если число было AC для позиции P, где оно реально появилось?
2. **Correction Matrix (12×12)** — из истории прогнозов: сдвиги ошибок системы
3. **Combined** = statistical × 0.7 + correction × 0.3
4. Финальный выбор: brute-force C(20,12)=125,970 комбинаций с ограничениями по позициям

**Архив CSV:** 7,961 тираж (янв–апр 2026), формат `DrawNumber;Date;Time;Num1..Num12`

**RI адаптация — комбинированная стратегия (2026-05-20):**

Для анти-кандидатной системы RI работает **инвертированно** по сравнению с 2x2:
- В 2x2: low RI = типичная комбинация → оставляем
- В 1224: high RI = редкая комбинация → хорошие анти-кандидаты (меньше шанс что выпадут вместе)

**Комбинированная стратегия (3 уровня):**
1. **Per-number RI (вес при голосовании)** — числа с высоким RI на своей позиции получают бонус к весу
2. **Inverted Combination RI (финальный фильтр)** — prefer наборы 12 анти-кандидатов с высоким общим RI; отбрасываем слишком типичные (low RI) с fallback
3. **RI как сигнал репутации триггеров** — триггеры, дающие анти-кандидатов с high RI-набором, получают бонус

**Pipeline:** A2-A11 → селектор (голоса + per-number RI) → формируем 12 → combination RI check → accept/fallback

**Статус (2026-05-22):**
- **Серверный pipeline (v5):** `orchestrator_v5.py` → `universal_analyzer_v6.py` (A2-A11) → `selector_v5.py` → `arbiter_v5.py`
- **Локальный offset-pipeline** (asymmetric triggers + dual matrix) — другая архитектура, не используется на сервере
- **RI ИНТЕГРИРОВАН** на сервере на 3 уровнях: (1) per-number scoring в selector_v5.py, (2) combination filter `_apply_ri_filter()`, (3) reputation bonus в arbiter_v5.py
- Серверный конфиг: `v5_analyzer/config_v5.yaml`, `analysis_depth: 11884`
- **Привязка к analysis_depth — ИСПРАВЛЕНО (2026-05-22):** удалён `history_size: 10000` из конфига, RI следует `analysis_depth` через fallback
- **Исправленный баг (2026-05-21):** RI фильтр обходился из-за сортировки — проверка RI шла на неотсортированном списке, а финальный прогноз сохранялся отсортированным (RI менялся). Исправление: сортировка ДО вызова `_apply_ri_filter()`

- Код запушен в `dev_v6_chaos_trigger` на `github.com:profitonlineivanov-arch/1224` (коммит `cc7df29`, 2026-05-22)

**Реализованные файлы:**
- `v5_analyzer/rarity_index.py` — RI анализатор (12 каналов=позиции, числа 1-24)
- `v5_analyzer/selector_v5.py` — интеграция уровней 1-2 (per-number вес + inverted combination фильтр)
- `v5_analyzer/arbiter_v5.py` — уровень 3 (RI бонус к репутации триггеров)
- `v5_analyzer/config_v5.yaml` — секция `rarity_index` (enabled, ri_weight=0.5, min_combination_ri=5)
- `unified_dashboard.py` — маршрут `/ri` + вкладка "📈 Rarity Index" на главной
- `templates/ri.html` — визуализация: таблица кодов, RI распределение, RI прогноза

**Эмпирические данные:** RI распределение по 5000 тиражам: RI=0-2 покрывает ~49% (типичные), RI≥8 — ~5.5% (редкие). Порог min_combination_ri=5.

**Исправленный баг (2026-05-21):** RI фильтр обходился из-за сортировки — проверка RI шла на неотсортированном списке, а финальный прогноз сохранялся отсортированным (RI менялся). Исправление: сортировка ДО вызова `_apply_ri_filter()`. Результат: Initial RI=11, финальный RI=11 (консистентно).

**Why:** Пользователь хочет расширить RI на другие лотереи. 1224 — первая за пределами 2x2. Особенность: лотерея "Всё или ничего" выигрывает и за 0, и за 12 совпадений.
**How to apply:** При реализации учитывать инверсию RI для анти-кандидатов. Порог combination RI подобрать эмпирически (для 12 каналов ожидается ~10-12 вместо 3 для 4 каналов в 2x2).
