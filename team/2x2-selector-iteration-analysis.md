---
name: 2x2 Selector Iteration Analysis
description: Завершённый reverse engineering — два запуска по 10k (с RI и без RI) сравнены, RI не даёт значимого преимущества
type: project
---

## 2x2 Selector Iteration Analysis — ЗАВЕРШЕНО 2026-06-08

### Запуск 1: С RI (завершён 2026-06-08 02:27)
- 10,000 тиражей, `--max-runs 1000`
- Результаты в `/root/projects/2x2/selector_iterations_10k.csv`
- 1+ matches: 10000 (100.0%)
- 2+ matches: 9995 (100.0%)
- 3+ matches: 6149 (61.5%)
- 4 matches: 274 (2.7%)
- avg runs: 1=2.9, 2=37.0, 3=293.6, 4=460.3

### Запуск 2: БЕЗ RI (завершён 2026-06-08 13:05)
- 10,000 тиражей, `--max-runs 1000`, флаг `--no-ri`
- Результаты в `/root/projects/2x2/selector_iterations_10k_no_ri.csv`
- Лог: `/root/projects/2x2/selector_iteration_10k_no_ri.log`
- 1+ matches: 10000 (100.0%)
- 2+ matches: 9999 (100.0%)
- 3+ matches: 6317 (63.2%)
- 4 matches: 264 (2.6%)
- avg runs: 1=2.8, 2=33.3, 3=296.9, 4=458.5

### Сравнение: RI vs no-RI
| Метрика | С RI | Без RI | Δ |
|---------|------|--------|---|
| 1+ matches | 100.0% | 100.0% | = |
| 2+ matches | 100.0% | 100.0% | = |
| 3+ matches | 61.5% | **63.2%** | **+1.7% без RI** |
| 4 matches | 2.7% | 2.6% | −0.1% |
| avg runs → 1 | 2.9 | 2.8 | быстрее без RI |
| avg runs → 2 | 37.0 | **33.3** | **−3.7 без RI** |
| avg runs → 3 | 293.6 | 296.9 | +3.3 |
| avg runs → 4 | 460.3 | 458.5 | −1.8 |

**Вывод: RI не даёт значимого преимущества.** На 10k тиражах разница в пределах 1-2% — нормальная дисперсия. Без RI даже чуть лучше на 3+ matches (63.2% vs 61.5%) и быстрее до 2 совпадений. Гипотеза пользователя о том, что RI улучшает качество — НЕ подтвердилась.

### Тест (5 draws, max_runs=100, no RI) — 2026-06-08 (предварительный)
- 1+ matches: 100% (avg 1.2 runs vs 3.8 с RI)
- 2+ matches: 80% (avg 3.8 runs vs 25 с RI)
- 3+ matches: 20% (avg 28 runs vs 21 с RI)
- 4 matches: 0% (недостаточно 100 runs)

**Why:** Этот первоначальный тест на 5 тиражах **вводил в заблуждение** — он предполагал что RI сильно замедляет Селектор. На полной выборке 10k этого эффекта нет.

### Ключевое изменение в коде
Файл `/root/projects/2x2/selector_iteration_analyzer.py`:
- Добавлен `import copy`
- `SelectorIterationAnalyzer.__init__` принимает `disable_ri: bool = False`
- `simulate_one_draw` делает `copy.deepcopy(self.config)` и при `disable_ri=True` выставляет `config['selection']['rarity_index']['enabled'] = False`
- CLI: флаг `--no-ri`

### Методология
- Для каждого тиража: загрузить anti-candidates через `predictions_v4.id` → `anti_candidates_history.prediction_id`
- Многократный перезапуск Селектора (полный пайплайн)
- `iter_matchK` = номер restart'а где впервые достигнуто K совпадений
- Сохранение в `predictions_v4.iter_match1-4`

### Предыдущая статистика (2026-05-29 endurance test)
- 98.2% = 1 итерация
- 1.8% = 2-7 итераций
- Max = 7 итераций

### Файлы результатов
- `/root/projects/2x2/selector_iterations_10k.csv` (516 KB) — с RI
- `/root/projects/2x2/selector_iterations_10k_no_ri.csv` (508 KB) — без RI
- `/root/projects/2x2/selector_iteration_10k.log` (42 MB) — лог с RI
- `/root/projects/2x2/selector_iteration_10k_no_ri.log` (7.4 KB) — лог без RI
