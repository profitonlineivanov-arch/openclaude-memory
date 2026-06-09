# 2x2 Selector Iterations Analysis (БЕГУЩИЙ ЭКСПЕРИМЕНТ)

## Текущий статус (2026-06-07 16:10)

**Запущен анализ на 500 тиражах** (328757-329256):
```
nohup python3 -u selector_iteration_analyzer.py --limit 500 --output selector_iterations_analysis.csv > selector_analyzer.log 2>&1 &
```

**Обнаружена ошибка**: `no such column: candidate` в `anti_candidates_history` — проверка имени колонки в БД

## Реализация

### Созданный файл
- `/root/projects/2x2/selector_iteration_analyzer.py`

### Fункционал
1. **IterationTrackingSelector** — встроен в `horizontal_selector_v4`:
   - Отслеживает `iter_match1-4` — итерации первого достижения 1/2/3/4 угаданных чисел
   
2. **SelectorIterationAnalyzer**:
   - `get_antecandidates_for_draw()` — Анти-кандидаты ДО тиража
   - `get_temperatures_for_draw()` — Температуры на момент тиража
   - `simulate_selector_for_draw()` — Повторный запуск Селектора
   - `batch_analyze(limit)` — С прогресс-баром (fallback tqdm)
   - `save_results_to_db()` — Запись в `predictions_v4`

### Schema (добавлено 2026-06-07)
```sql
ALTER TABLE predictions_v4 ADD COLUMN iter_match1 INTEGER;
ALTER TABLE predictions_v4 ADD COLUMN iter_match2 INTEGER;
ALTER TABLE predictions_v4 ADD COLUMN iter_match3 INTEGER;
ALTER TABLE predictions_v4 ADD COLUMN iter_match4 INTEGER;
```

## Предыдущая статистика (2026-05-29 endurance test)
- 98.2% = 1 итерация
- 1.8% = 2-7 итераций
- Мax = 7 итераций

На 20 draws × 500 attempts:
- 1 угаданное: 100%
- 2 угаданных: 100%
- 3 угаданных: 75%
- 4 угаданных: 5%