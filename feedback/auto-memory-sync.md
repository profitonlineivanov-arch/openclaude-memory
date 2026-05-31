---
name: Memory sync must be automatic
description: User expects memory sync (git pull/push) to happen automatically at session start/end via hooks — not manually
type: feedback
---

Memory sync должна происходить автоматически при открытии и закрытии сессии, без ручного вызова.

**Why:** Пользователь работает с двумя агентами (desktop + mobile) и рассчитывает, что память синхронизируется сама. Ручная синхронизация — лишний шаг, который легко забыть.

**How to apply:** В settings.json настроены хуки:
- `SessionStart` → `git pull --rebase origin main` (скачать изменения)
- `SessionEnd` → `bash sync.sh` (pull + push)

Если хуки не сработали (сессия завершена не через /exit или Ctrl+C), нужно вручную вызвать `bash sync.sh sync` в директории memory перед выходом. Всегда проверяй синхронизацию в конце сессии.
