---
name: Memory sync — memory only, no configs
description: sync.sh синхронизирует только .md память через GitHub; configs/ исключены из tracking (2026-06-19)
type: feedback
---

**Архитектура (2026-06-19):**
- PAT токен в `config/sync-remote.txt` (в .gitignore)
- sync.sh читает токен из файла, HTTPS remote
- `configs/` в .gitignore — провайдеры, хуки, тулзы НЕ синхронизируются
**Аутентификация (обновлено 2026-06-19):**
- `gh auth login --web -p https` (device flow в Termux, код передать пользователю)
- `git config --global credential.helper '/data/data/com.termux/files/usr/bin/gh auth git-credential'`
- gh credential helper автоматически отдаёт токен при git push/pull — токен в URL НЕ нужен
- Токен-файл `config/sync-remote.txt` больше не используется

**Что synced:**
- .md файлы памяти (feedback, project, reference, user, team)
- MEMORY.md индексы

**Что НЕ synced:**
- .openclaude.json, settings.json, .openclaude-profile.json
- settings.local.json, config/sync-remote.txt

**Why:** Пользователь решил что настройки — устройство-специфичные. Ollama-провайдеры ломали Termux. Скиллы и тулзы разные между платформами.

**How to apply:** Не пытаться синхронизировать конфиги. Для нового устройства — настроить провайдеры вручную.
