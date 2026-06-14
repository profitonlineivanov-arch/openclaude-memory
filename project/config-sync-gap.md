---
name: Config sync RESOLVED
description: configs synced via sync.sh + configs/ in memory repo (settings.local.json excluded — contains API keys)
type: project
---

Настройки OpenClaude НЕ синхронизируются между устройствами. Синхронизируется только `memory/` через GitHub (openclaude-memory repo).

**Что НЕ синхронизируется:**
- `.openclaude.json` — провайдеры, API-ключи, статистика проектов
- `settings.json` — хуки, плагины, модель, env
- `settings.local.json` — permissions, MCP-серверы
- `.openclaude-profile.json` — активный профиль провайдера

**Что работает:** memory/ (hooks SessionStart/SessionEnd через sync.sh).

**РЕШЕНО (2026-06-14):**
- `configs/` в memory repo: `.openclaude.json`, `.openclaude-profile.json`, `settings.json` — git-tracked
- `settings.local.json` исключён из репо (содержит API-ключи в curl-командах permissions, GitHub push protection блокирует)
- `sync.sh` расширен: pull/push/sync с copy_configs_to_oc + copy_configs_from_oc
- Хуки в settings.json: SessionStart = `sync.sh pull` (git pull + copy_configs_to_oc), SessionEnd = `sync.sh` (full sync)
- История репо переписана для удаления секретов (force push)

**Why:** Пользователь работает на desktop + mobile (Termux), хочет единое окружение.
**How to apply:** Работает. Конфиги синхронизируются автоматически при старте/конце сессии.
