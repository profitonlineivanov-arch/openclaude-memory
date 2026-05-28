---
name: OpenClaude Memory Sync
description: GitHub-based memory sync between desktop and mobile OpenClaude agents
type: reference
---

Репозиторий: https://github.com/profitonlineivanov-arch/openclaude-memory

**Синхронизация памяти между агентами:**
- Desktop: `C:\Users\admin\.openclaude\projects\C--Users-admin\memory\` (git clone)
- Mobile: путь к памяти OpenClaude на телефоне (git clone того же репозитория)

**Команды:**
- `./sync.sh pull` — скачать изменения
- `./sync.sh push` — отправить изменения
- `./sync.sh sync` — pull + push

**Why:** Пользователь работает с двумя агентами (desktop + mobile) и хочет общую память.
**How to apply:** При запуске сессии делать pull, при завершении — push. Оба агента должны быть в одном репозитории.
