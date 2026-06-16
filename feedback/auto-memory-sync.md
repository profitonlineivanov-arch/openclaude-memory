---
name: Memory sync must be automatic — currently BROKEN
description: Auto sync via hooks not working on Windows: stuck rebase + no git auth. Fix committed (7bbed53) but not working.
type: feedback
---

Memory sync должна происходить автоматически при SessionStart/SessionEnd через хуки.

**Текущий статус (2026-06-16): СЛОМАНО.**

**Проблемы:**
1. `sync.sh` использовал `git pull --rebase` — при конфликтах зависает в interactive rebase, блокируя всю синхронизацию
2. Фикс (git_safe_pull с merge вместо rebase) в коммите `7bbed53`, но не был деплоен в working tree
3. На Windows нет git auth (ни SSH ключа, ни credential helper) — push падает молча

**Хуки в settings.json:**
- `SessionStart` → `bash ~/.openclaude/memory-sync.sh pull 2>/dev/null`
- `SessionEnd` → `bash ~/.openclaude/memory-sync.sh 2>/dev/null`

**Why:** Пользователь работает с двумя агентами (desktop + mobile) и рассчитывает, что память синхронизируется сама.
**How to apply:** НЕ заверять пользователя что sync работает, пока не проверено: git auth настроен, sync.sh с git_safe_pull запушен на GitHub, pull/push реально проходят без ошибок.
