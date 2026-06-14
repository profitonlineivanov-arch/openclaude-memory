---
name: Config sync RESOLVED
description: configs synced via sync.sh + configs/ in memory repo; providers RESTORED from GitHub (other machine pushed); sync.sh pull has file-lock bug
type: project
---

Конфиги синхронизируются между устройствами через `configs/` в GitHub-репо (openclaude-memory).

**Что синхронизируется:**
- `.openclaude.json` — провайдеры, API-ключи, статистика проектов
- `settings.json` — хуки, плагины, модель, env, enabledPlugins
- `.openclaude-profile.json` — активный профиль провайдера
- `memory-sync.sh` — сам скрипт синхронизации

**Что НЕ синхронизируется:**
- `settings.local.json` — permissions (содержит API-ключи, GitHub push protection блокирует)
- `plugins/installed_plugins.json` — плагины нужно устанавливать на каждом устройстве отдельно

**sync.sh логика:**
- `pull`: `git pull --rebase` → `copy_configs_to_oc` (configs/ → ~/.openclaude/)
- `push`: `copy_configs_from_oc` ( ~/.openclaude/ → configs/) → `git add` → `git commit` → `git push`
- `sync`: pull + push в одной операции

**Хуки в settings.json:**
- SessionStart = `sync.sh pull` (подтянуть конфиги перед работой)
- SessionEnd = `sync.sh` (сохранить и запушить изменения)

**Баг sync.sh pull (2026-06-14):** `copy_configs_to_oc` молча проваливается во время активной сессии — `.openclaude.json` заблокирован процессом OpenClaude. `git pull` срабатывает (configs/ обновляются), но `cp` в `~/.openclaude/` тихо падает. **Workaround:** ручной `cp` из `configs/` → `~/.openclaude/` после pull. **Fix needed:** sync.sh должен детектить ошибку копирования и сообщать, или использовать `cp -f`.

**Инцедент 2026-06-14:** Ноутбук создал свежий `.openclaude.json` (firstStartTime=08:41, только DeepSeek). Другая машина (Termux) имела полный конфиг с 4 провайдерами и запушила их в `configs/`. `sync.sh pull` подтянул configs/ из GitHub, но НЕ скопировал в `~/.openclaude/`. Ручной `cp` восстановил всех 4 провайдеров.

**Why:** Пользователь работает на desktop + mobile (Termux), хочет единое окружение.
**How to apply:** При потере провайдеров на одном устройстве — проверить `configs/` в memory-репо (там может быть полный конфиг с другого устройства). Если `sync.sh pull` не применяет — скопировать вручную.
