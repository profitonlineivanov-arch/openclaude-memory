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

SSH ключ:
- Termux: ~/.ssh/id_ed25519 (ed25519, comment: openclaude@termux)
- Публичный ключ: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKD1r3vMmew/nWdx1Nr0VcmCCYN4zZxc3hjpW/8og41w openclaude@termux
- Статус (2026-05-29): ключ НЕ добавлен в GitHub — нужен https://github.com/settings/keys
- После добавления: `git remote set-url origin git@github.com:profitonlineivanov-arch/openclaude-memory.git` для SSH push

Автосинхронизация:
- При старте сессии: cd <memory-path> && git pull --rebase origin main
- При завершении сессии: cd <memory-path> && bash sync.sh
