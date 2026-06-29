---
name: OpenClaude Memory Sync
description: GitHub sync for shared memory - profitonlineivanov-arch/openclaude-memory
type: reference
---

Репозиторий памяти: https://github.com/profitonlineivanov-arch/openclaude-memory

Путь: /data/data/com.termux/files/home/.openclaude/projects/-data-data-com-termux-files-home/memory/

Настройка: 2026-05-29, обновлена 2026-06-19:
- git init, ветка: main
- Remote: HTTPS (sync.sh переключает автоматически)
- sync.sh доступен для автосинхронизации
- configs/ исключены из tracking (2026-06-19, commit 80aaad3)
- Синхронизируются ТОЛЬКО .md файлы памяти

Аутентификация:
- PAT токен в config/sync-remote.txt (в .gitignore)
- **2026-06-19:** токен-файл отсутствует, push падает. Нужно восстановить или gh auth login.

Алиасы в ~/.bashrc:
- `mpull` — git pull --rebase origin main
- `mpush` — bash sync.sh push
- `msync` — bash sync.sh (полная синхронизация)

Hooks в settings.json (автоматически):
- SessionStart → git pull --rebase origin main
- SessionEnd → bash sync.sh
