---
name: Auto session handoff
description: Автоматический перенос контекста между Termux и Windows через hooks + git, без ручных команд
type: feedback
---

# Auto session handoff protocol (2026-07-08)

## Как работает — ПОЛНОСТЬЮ АВТОМАТИЧЕСКИ

SessionEnd hook сам извлекает последние 15 сообщений из JSONL сессии, пишет handoff, пушит в GitHub.
SessionStart hook пуллит, проверяет hostname, если cross-device — помечает handoff как pending.

**Без команд от пользователя. Без AI-вмешательства. Просто закрыть сессию и открыть на другом устройстве.**

## Конвейер

1. **SessionEnd →** `session-handoff.sh`: ищет JSONL по sessionId → извлекает последние 15 сообщений → пишет `handoffs/latest.md` с device/hostname/session_id → git add + commit + push
2. **GitHub** хранит handoff
3. **SessionStart →** `memory-sync.sh pull` → `session-pickup.sh`: сравнивает hostname из handoff с текущим → если разные → копирует в `_handoff_pending.md`
4. **AI старта:** видит `_handoff_pending.md` → читает → продолжает → удаляет

## Скрипты

- `~/.openclaude/session-handoff.sh` — Python скрипт, извлекает JSONL, пишет handoff
- `~/.openclaude/session-pickup.sh` — проверка hostname, копирование
- `~/.openclaude/settings.json` — hooks: SessionStart (pull + pickup), SessionEnd (handoff + push)

## Важно

- Не ждать команды от пользователя
- Не писать session_context.md вручную
- После прочтения `_handoff_pending.md` — удалить его
- На Windows нужно скопировать те же скрипты и hooks

## Предыдущая версия (SUPERSEDED)

Ранее handoff требовал: пользователь говорит «сохрани», AI пишет `handoff/handoff.md`, запускает sync.sh. Этот подход устарел — всё работает автоматически.