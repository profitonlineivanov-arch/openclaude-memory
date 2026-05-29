---
name: OpenClaude Memory Sync
description: GitHub-based memory sync between desktop and mobile OpenClaude agents
type: reference
---

Репозиторий: https://github.com/profitonlineivanov-arch/openclaude-memory

**Синхронизация памяти между агентами:**
- Desktop: `C:\Users\admin\.openclaude\projects\C--Users-admin\memory\` (git clone)
- Mobile (Termux): `/data/data/com.termux/files/home/.openclaude/projects/-data-data-com-termux-files-home/memory/` (git clone)
- Remote: git@github.com:profitonlineivanov-arch/openclaude-memory.git (SSH)

**Команды:**
- `./sync.sh pull` — скачать изменения
- `./sync.sh push` — отправить изменения
- `./sync.sh sync` — pull + push
- Алиасы (mobile): `mpull`, `mpush`, `msync`

**Hooks (settings.json):**
- SessionStart → автоматический pull
- SessionEnd → автоматический sync.sh

**Why:** Пользователь работает с двумя агентами (desktop + mobile) и хочет общую память.
**How to apply:** Hooks настроены в settings.json — синхронизация происходит автоматически. Ручные команды через алиасы mpull/mpush/msync.
