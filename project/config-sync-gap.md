---
name: Config sync not implemented
description: User wants settings/providers/plugins/skills/MCP to sync across devices — currently only memory/ syncs via GitHub
type: project
---

Настройки OpenClaude НЕ синхронизируются между устройствами. Синхронизируется только `memory/` через GitHub (openclaude-memory repo).

**Что НЕ синхронизируется:**
- `.openclaude.json` — провайдеры, API-ключи, статистика проектов
- `settings.json` — хуки, плагины, модель, env
- `settings.local.json` — permissions, MCP-серверы
- `.openclaude-profile.json` — активный профиль провайдера

**Что работает:** memory/ (hooks SessionStart/SessionEnd через sync.sh).

**Решено — вариант 3 (2026-06-14):**
- `configs/` в memory repo: `.openclaude.json`, `.openclaude-profile.json`, `settings.json`, `settings.local.json` — git-tracked
- `sync.sh` расширен: pull/push/sync с copy_configs_to_oc + copy_configs_from_oc
- Хуки в settings.json: SessionStart = `git pull --rebase`, SessionEnd = `bash sync.sh`

**Why:** Пользователь работает на desktop + mobile (Termux), хочет единое окружение.
**How to apply:** Работает. Конфиги синхронизируются автоматически при старте/конце сессии.
