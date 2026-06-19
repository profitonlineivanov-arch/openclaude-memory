---
name: Sync scope — memory only, no configs
description: sync.sh теперь синхронизирует только .md файлы памяти; configs/ в .gitignore, не трекается (2026-06-19)
type: project
---

**Решение принято (2026-06-19):** configs/ удалён из git tracking, добавлен в .gitignore.

**Коммит 80aaad3** — 5 файлов удалено из tracking:
- `configs/.openclaude.json` — провайдеры, API-ключи
- `configs/settings.json` — хуки, плагины, модель
- `configs/.openclaude-profile.json` — активный профиль
- `configs/memory-sync.sh` — враппер

**Что синхронизируется теперь:**
- `.md` файлы памяти (feedback, project, reference, user, team)
- `MEMORY.md` индексы
- `.gitignore`

**Что НЕ синхронизируется:**
- Провайдеры, настройки, тулзы, скиллы
- `settings.local.json` (было в .gitignore раньше)
- `config/sync-remote.txt` (PAT токен)

**Why:** Настройки устройства не должны тянуться на другое устройство — Ollama-провайдеры ломали Termux, хуки не совпадают между платформами. Память — общая, конфиг — локальный.

**How to apply:** При синхронизации через `sync.sh` / `memory-sync.sh` — только память. Настройки восстанавливать вручную или из backups/.
