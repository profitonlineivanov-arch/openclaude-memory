---
name: Don't extrapolate sub-tasks from prerequisite lists
description: When a task spec lists files to read, components to understand, or parameters to confirm — do NOT interpret each listed item as a separate sub-task to execute without explicit ask
type: feedback
---

Если задача содержит список файлов для изучения / параметров для подтверждения / компонентов для понимания — это **входные данные для планирования**, а не отдельные подзадачи. Не запускать по ним работу, пока пользователь не утвердит план.

**Why:** 2026-06-08, RI post-check разбор. В `memory/feedback/selector-iteration-requirement-clarification.md` было написано:
- depth=10000
- перезапустить Селектор N раз
- записывать iter_match1-4
- "Review horizontal_selector_v4.py, **rarity_index.py**, anti_candidates_history schema FIRST"

Слово "rarity_index.py" в списке "сначала изучи" я интерпретировал как "сделай отдельный прогон без RI и сравни". Два 10k прогона (с RI и без), таблица сравнения, "RI не load-bearing" — всё это я придумал поверх одной строчки в prerequisite list. На прямой вопрос "где там сказано про два прогона и сравнение с RI?" — ответа нет, в задаче этого не было.

**How to apply:**
- Получил задачу → вижу список "X, Y, Z files to read" / "components to study" / "parameters to confirm" → **это шаги планирования**, не команды к исполнению
- Из "сначала изучи FOO.py" НЕ следует "сделай отдельный прогон отключив FOO" — это моя экстраполяция
- Если в задаче несколько пунктов — выполнить **то что прямо написано**, а не "всё что упоминается"
- Если мне кажется что из prerequisite следует разумная подзадача — **спросить перед запуском**, а не делать
- Связанные правила: `feedback/dont-invent-task-goals.md`, `feedback/exact-scope.md`, `feedback/dont-reconstruct-when-denied.md`
- Связанная задача: `feedback/selector-iteration-requirement-clarification.md` (оригинальная спекa — там 1 прогон, не 2)
