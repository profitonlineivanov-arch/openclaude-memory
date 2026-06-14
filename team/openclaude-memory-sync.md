---
name: OpenClaude Memory Sync
description: GitHub-based memory sync between desktop and mobile OpenClaude agents
type: reference
---

Репозиторий: https://github.com/profitonlineivanov-arch/openclaude-memory

**Синхронизация памяти между агентами:**
- Desktop (Windows): `C:\Users\Admin\.openclaude\projects\C--Users-Admin\memory\` (git clone, 2026-06-14)
- Mobile (Termux): `/data/data/com.termux/files/home/.openclaude/projects/-data-data-com-termux-files-home/memory/` (git clone)
- Remote: git@github.com:profitonlineivanov-arch/openclaude-memory.git (SSH)

**Команды:**
- `bash sync.sh pull` — скачать + применить конфиги
- `bash sync.sh push` — отправить изменения
- `bash sync.sh sync` — pull + push

**Wrapper (path-agnostic):**
- `bash ~/.openclaude/memory-sync.sh [pull|sync]` — автодискаверит memory/ в projects/*/memory
- Деплоится из configs/memory-sync.sh при sync.sh pull
- Хуки в settings.json используют wrapper вместо хардкодных путей

**Hooks (settings.json):**
- SessionStart → `bash ~/.openclaude/memory-sync.sh pull`
- SessionEnd → `bash ~/.openclaude/memory-sync.sh` (sync)

**New device bootstrap:**
1. Установить OpenClaude, запустить один раз
2. `ls ~/.openclaude/projects/` — найти имя project-папки
3. `git clone git@github.com:profitonlineivanov-arch/openclaude-memory.git ~/.openclaude/projects/<NAME>/memory`
4. `cd ~/.openclaude/projects/<NAME>/memory && bash sync.sh pull`
5. Добавить провайдер, перезапустить

**Why:** Пользователь работает с двумя агентами (desktop + mobile) и хочет общую память.
**How to apply:** Hooks настроены в settings.json — синхронизация происходит автоматически. Ручные команды через sync.sh.
