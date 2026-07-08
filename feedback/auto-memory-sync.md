---
name: Memory sync — sessions only, no memory
description: sync scope narrowed — GitHub sync should only transfer sessions, not .md memory (2026-07-06)
type: feedback
---

**Архитектура (2026-06-19):** 
- PAT токен в `config/sync-remote.txt` (в .gitignore)
- sync.sh читает токен из файла, HTTPS remote
- `configs/` в .gitignore — провайдеры, хуки, тулзы НЕ синхронизируются

**Аутентификация (обновлено 2026-06-19):**
- `gh auth login --web -p https` (device flow в Termux, код передать пользователю)
- `git config --global credential.helper '/data/data/com.termux/files/usr/bin/gh auth git-credential'`
- gh credential helper автоматически отдаёт токен при git push/pull

**Что synced (было):**
- .md файлы памяти (feedback, project, reference, user, team)
- MEMORY.md индексы

**Что synced (должно быть, 2026-07-06):**
- Только сессии. Память/конфиги — нет.

**Why:** Разные устройства — разные локальные модели/конфиги. Memory файлы про Ollama на телефоне не нужны на ноутбуке и наоборот. Merge conflicts неизбежны.

**How to apply:** Не синхронизировать .md память между устройствами. Настроить session-only sync. Что именно "сессии" — уточнить у пользователя.