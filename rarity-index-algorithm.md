---
name: Rarity Index Algorithm
description: Distribution overlay method from Pikurika video — universal algorithm for any lottery. Assigns symmetric frequency codes to numbers per channel, combination RI = |sum of codes|.
type: reference
---

## Источник

Видео Pikurika: https://www.youtube.com/watch?v=SslkAlENdSw&list=PL4si-qxbnC3hjBG1YcP46MQjGjoJ2je9U
Локальная копия: `C:\Users\admin\Downloads\Как раскрыть СЕКРЕТНЫЙ КОД лотерей...mp4`
Транскрипция (whisper medium, RU): `C:\Users\admin\Downloads\rarity_index_audio.txt`

## Алгоритм (универсальный для любой лотереи)

### Шаг 1: Определить каналы
Разбить тираж на пары → для каждой пары канал = min и max.
Для 2x2: [n1,n2,n3,n4] → A=min(n1,n2), B=max(n1,n2), C=min(n3,n4), D=max(n3,n4).
Для других лотерей — аналогично, каналов может быть больше.

### Шаг 2: Частоты
Для каждого канала подсчитать, сколько раз каждое число встречалось в истории.

### Шаг 3: Нормализация
Нормализовать частоты к max=1000:
`normalized[num] = (freq[num] / max_freq) * 1000`

### Шаг 4: Сортировка
Отсортировать числа по нормализованной частоте (убывание).

### Шаг 5: 5 категорий
Разделить отсортированный список на 5 групп (по ~20% каждая):
- Категория 0: самые частые (top)
- Категория 4: самые редкие (bottom)

### Шаг 6: Симметричные коды
| Категория | Код |
|-----------|-----|
| 0 (top) | 0 |
| 1-2 (mid) | ±1 |
| 3-4 (bottom) | ±2 |

Знак: число < пикового (max частота) → отрицательный, число > пикового → положительный.
Пиковое число → код 0.
Коды обнуляются при суммировании — это ключевое свойство.

### Шаг 7: RI комбинации
`RI = |code_A + code_B + code_C + ... + code_N|`
Чем ниже RI — тем «стабильнее» комбинация.

## Результат для 2x2 (5000 тиражей)
- RI=0: 23.5%, RI=1: 38.8%, RI=2: 25.0%, RI=3: 10.1%, RI=4+: 2.6%
- RI 0-3 покрывает 97.4% реальных тиражей

## Структура каналов — ИСПРАВЛЕНО (2026-05-22)

### 2x2: два независимых поля (v3)
**Решение:** RI = max(RI_поле1, RI_поле2), где каждое поле = 2 канала (min, max).
- Поле 1: A1=min(n1,n2), B1=max(n1,n2), RI_1 = |A1+B1|
- Поле 2: A2=min(n3,n4), B2=max(n3,n4), RI_2 = |A2+B2|
- Диапазон: 0-4, фактически 0-2 (из-за корреляции min≤max в каждом поле)
- Причина выбора max: фокусируется на «худшем» поле, не размывает результат

**Эмпирические данные (depth=24806):** RI=0: 12.4%, RI=1: 44.4%, RI=2: 43.1%, RI=3+: 0%

### 1224: 12 каналов — корректно, без изменений
Серверный файл `/root/projects/1224/v5_analyzer/rarity_index.py` — 12 каналов (по позиции, числа 1-24).
**RI интегрирован** в серверный pipeline (v5) на 3 уровнях:
1. Per-number scoring boost в `selector_v5.py`
2. Combination RI filter `_apply_ri_filter()` в `selector_v5.py`
3. Reputation bonus в `arbiter_v5.py`

### Привязка к `analysis_depth` — ИСПРАВЛЕНО (2026-05-22)
Удалён `history_size: 10000` из конфигов обоих проектов. RI следует `analysis_depth` через fallback-цепочку:
- Селектор: `ri_history_size = ri_cfg.get('history_size') or config.get('analysis', {}).get('analysis_depth', 10000)`
- `__main__` обоих файлов RI: функция `_load_analysis_depth()` читает из config_v5.yaml

## Сильные стороны метода
Простота O(N)/O(1), симметричные коды позволяют компенсацию при суммировании, порог RI≤3 отсекает ~30% редких комбинаций.

## Применение к другой лотерее
1. Определить каналы (пары чисел → min/max)
2. Собрать историю (рекомендуется 1000+ тиражей)
3. Запустить алгоритм
4. Проверить распределение RI на истории
5. Установить порог (обычно RI ≤ 3 отсеивает ~97%)
6. Интегрировать в селектор: combination-level фильтр + per-number бонус

Реализация для 2x2: `C:\Users\admin\Downloads\rarity_index_v2.py` (366 строк) + `C:\Users\admin\Downloads\horizontal_selector_v4_new.py` (392 строки, интеграция RI)
Серверная копия: `/root/projects/2x2/rarity_index.py` (v2)
