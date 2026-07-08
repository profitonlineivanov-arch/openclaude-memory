---
name: Cross-device session handoff
description: Механизм переноса контекста между Termux и Windows через git handoff файл
type: feedback
---

# Cross-device session handoff protocol

## Как работает

При переключении между устройствами (Termux ↔ Windows) контекст сессии сохраняется в `handoff/handoff.md` в памяти, которая синхронизируется через git.

## Процесс

1. **Сохранение:** Пользователь говорит «сохрани/сохранись/переключаюсь» → AI пишет `handoff/handoff.md` с текущим состоянием, обновляет MEMORY.md, запускает `sync.sh push`
2. **Восстановление:** На другом устройстве сессия стартует → Hook пуллит память → AI видит `handoff/handoff.md` в MEMORY.md → читает → продолжает → очищает handoff

## Структура handoff.md
- current task
- last actions
- next steps
- active files/context
- pending decisions

## Правила
- Handoff пишется ТОЛЬКО когда пользователь явно запросил сохранение
- После прочтения handoff очищается (замена на заглушку или удаление из MEMORY.md)
- Не дублировать то, что уже есть в других memory файлах