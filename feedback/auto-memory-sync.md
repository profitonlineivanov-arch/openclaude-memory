---
name: Memory sync — FIXED with token file + HTTPS
description: Auto sync via hooks now works on Windows: HTTPS + PAT token file replaces broken SSH
type: feedback
---

**Решение найдено (2026-06-16).**

**Финальный подход:**
- PAT токен хранится в файле `config/sync-remote.txt` (в .gitignore, не коммитится)
- sync.sh читает токен из файла: `sed -n '2p' config/sync-remote.txt | sed 's|https://[^:]*:||' | sed 's|@github.com.*||'`
- GITHUB_TOKEN env var не используется (не пробрасывается в MSYS2 bash)
- HTTPS remote для автоматики, SSH remote для терминала

**Почему не SSH:**
- MSYS2 bash не видит Windows ssh-agent
- Git Credential Manager использует `manager` (кроссплатформенный), не `wincred`
- PAT с HTTPS решил проблему

**Статус (2026-06-16):** РАБОТАЕТ. 3 коммита запушены, auto-sync хуки готовы к автоматической работе.

**Важно:** Локальные модели (Ollama) НЕ синхронизируются — на другом устройстве работать не будут.