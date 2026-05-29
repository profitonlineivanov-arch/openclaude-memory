---
name: OpenClaude Memory Sync
description: GitHub sync for shared memory - profitonlineivanov-arch/openclaude-memory
type: reference
---

Репозиторий памяти: https://github.com/profitonlineivanov-arch/openclaude-memory

Путь: /data/data/com.termux/files/home/.openclaude/projects/-data-data-com-termux-files-home/memory/

Настройка выполнена 2026-05-29:
- git init, ветка: main
- Remote: git@github.com:profitonlineivanov-arch/openclaude-memory.git (SSH)
- sync.sh доступен для автосинхронизации

SSH ключ:
- Termux: ~/.ssh/id_ed25519 (ed25519, comment: openclaude@termux)
- Публичный ключ: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKD1r3vMmew/nWdx1Nr0VcmCCYN4zZxc3hjpW/8og41w openclaude@termux
- Статус: SSH добавлен в GitHub, push работает

Алиасы в ~/.bashrc:
- `mpull` — git pull --rebase origin main
- `mpush` — bash sync.sh push
- `msync` — bash sync.sh (полная синхронизация)

Hooks в settings.json (автоматически):
- SessionStart → git pull --rebase origin main
- SessionEnd → bash sync.sh
