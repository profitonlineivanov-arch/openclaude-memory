---
name: 2x2 Iteration Tuner
description: Iteration Tuner — система оптимизации числа итераций Селектора (profile + feedback), спека в iteration-tuner-spec.md
type: project
---

## Iteration Tuner

Система из двух скриптов для нахождения оптимального числа итераций Селектора.

**Идея:** Селектор делает N прогнозов и выдаёт N-й (не первый). N — оптимальное число итераций, найденное статистически. Между первой попыткой и экстремальной (500) есть "sweet spot" — итерация, дающая максимум попаданий.

## Этап 1: Profile Collector — ЗАВЕРШЁН (2026-05-29, 19.3 мин)

20 draws × 500 attempts, hit count каждого прогона.
Quick summary (предварительно, 20 draws):
- ≥2 числа: best at attempt **#315** (P=0.400)
- ≥3 числа: best at attempt **#16** (P=0.100)
- Результат: `/tmp/iteration_profile.json`

## Этап 1b: Deep Run — ЗАПУЩЕН (2026-05-29 ~15:42 UTC)

Скрипт `iteration_profile_deep.py` — расширяет историю, пропускает уже обработанные draws.
- Глубина: 80 draws, новых к обработке: 53
- Дописывает в `/tmp/iteration_stats.json` (ту же БД, что и feedback)
- Ожидаемое время: ~50 мин
- Лог: `/tmp/iteration_profile_deep_output.txt`

## Этап 2: Feedback Script — ЗАПУЩЕН (2026-05-29)

- `--once` (один тираж) или `--loop` (polling каждые 5мин/300с)
- Накопительная БД: `/tmp/iteration_stats.json` (инициализирована 20 draws из profile)
- Запущен в --loop: `nohup python3 -u /tmp/iteration_feedback.py --loop`
- Лог: `/tmp/iteration_feedback_output.txt`

**Серверные файлы:**
- `/tmp/iteration_profile.py` → `/tmp/iteration_profile.json`
- `/tmp/iteration_profile_deep.py` → `/tmp/iteration_stats.json` (append)
- `/tmp/iteration_feedback.py` → `/tmp/iteration_stats.json` (append)
- Спека: `/data/data/com.termux/files/home/tmp/iteration-tuner-spec.md`

**Критически важно:** Каждый тираж обрабатывается с уникальными условиями — AC от Triple Beam с cutoff на этот тираж, температуры, features.

**Why:** Пользователь хочет повысить результативность Селектора через обратный инжиринг — найти оптимальное число итераций и адаптивно корректировать его.
**How to apply:** После сбора данных — анализ кривых P(≥T, K), интеграция в конфиг Селектора.
