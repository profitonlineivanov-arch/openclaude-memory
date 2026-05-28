---
name: OpenClaude Memory Sync
description: GitHub sync for shared memory - profitonlineivanov-arch/openclaude-memory
type: reference
---

Репозиторий памяти: https://github.com/profitonlineivanov-arch/openclaude-memory

Путь: /data/data/com.termux/files/home/.openclaude/projects/-data-data-com-termux-files-home/memory/

Настройка выполнена 2026-05-29:
- git init сделан
- remote: origin -> https://github.com/profitonlineivanov-arch/openclaude-memory.git
- ветка: main
- sync.sh доступен для автосинхронизации

Автосинхронизация:
- При старте сессии: cd <memory-path> && git pull --rebase origin main
- При завершении сессии: cd <memory-path> && bash sync.sh

Для push нужна авторизация GitHub (token или SSH).
