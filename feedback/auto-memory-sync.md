---
name: Memory sync — memory only, no configs
description: sync.sh синхронизирует только .md память через GitHub; configs/ исключены из tracking (2026-06-19)
type: feedback
---

**Архитектура (2026-06-19):**
- PAT токен в `config/sync-remote.txt` (в .gitignore)
- sync.sh читает токен из файла, HTTPS remote
- `configs/` в .gitignore — провайдеры, хуки, тулзы НЕ синхронизируются
- **2026-06-19:** токен-файл ОТСУТСТВУЕТ (удалился вместе с configs/). Push без токена падает. Fix:
  1. `gh auth login --web -p https` (device flow в Termux, код передать пользователю)
  2. `gh auth token` → получить gho_...
  3. `git remote set-url origin "https://user:TOKEN@github.com/..."` → push → `git remote set-url origin "https://github.com/..."` (вернуть чистый URL)
  - gh auth НЕ делает git push автоматически — нужен token в URL или credential helper

**Что synced:**
- .md файлы памяти (feedback, project, reference, user, team)
- MEMORY.md индексы

**Что НЕ synced:**
- .openclaude.json, settings.json, .openclaude-profile.json
- settings.local.json, config/sync-remote.txt

**Why:** Пользователь решил что настройки — устройство-специфичные. Ollama-провайдеры ломали Termux. Скиллы и тулзы разные между платформами.

**How to apply:** Не пытаться синхронизировать конфиги. Для нового устройства — настроить провайдеры вручную.
