---
<<<<<<< HEAD
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
=======
name: Config sync RESOLVED — fully portable
description: configs synced via sync.sh + configs/ in memory repo; memory-sync.sh wrapper auto-discovers memory/ on any device
type: project
---

Настройки OpenClaude синхронизируются через `sync.sh` + `configs/` в memory repo.

**Что синхронизируется (git-tracked в configs/):**
- `.openclaude.json` — провайдеры, API-ключи, статистика
- `settings.json` — хуки, плагины, модель, env
- `.openclaude-profile.json` — активный профиль провайдера
- `memory-sync.sh` — враппер для универсальных хуков

**Что НЕ синхронизируется:**
- `settings.local.json` — содержит API-ключи в curl-командах permissions, GitHub push protection блокирует (GH013). Добавлен в `.gitignore`, история переписана для удаления секретов.

**Как работает:**
- `memory-sync.sh` — враппер, автодискаверит `memory/` в `~/.openclaude/projects/*/memory`
- `sync.sh pull` — git pull + copy_configs_to_oc + deploy memory-sync.sh (SessionStart hook)
- `sync.sh` (sync) — pull + push (SessionEnd hook)
- `sync.sh push` — copy_configs_from_oc + commit + push
- Хуки: `bash ~/.openclaude/memory-sync.sh [pull|sync]` — path-agnostic, работает на любом устройстве

**Bootstrap на новом устройстве (2026-06-14):**
1. Установить OpenClaude, запустить один раз (создаёт ~/.openclaude/)
2. `git clone git@github.com:profitonlineivanov-arch/openclaude-memory.git <memory-dir>`
3. `bash sync.sh pull` — развёртывает конфиги + memory-sync.sh
4. Добавить провайдер с API-ключом (рекомендовано DeepSeek)
5. Перезапустить — хуки заработают

**Критичный готча (2026-06-14):**
- OpenClaude формирует имя project-директории из хеша рабочей папки. На Termux это `-data-data-com-termux-files-home`, на Windows `-C--Users-Admin` (зависит от пути запуска).
- Память работает ТОЛЬКО если memory/ лежит внутри правильной project-директории.
- `memory-sync.sh` автодискаверит memory/ в `~/.openclaude/projects/*/memory` — это решает хуки.
- Но сам агент ищет memory по своему project-path, который может не совпасть с тем куда клонирован репо.
- Решение: запустить `ls ~/.openclaude/projects/` на новом устройстве, найти созданную папку, клонировать репо внутрь неё как `memory/`.
- **Windows env:** configs/settings.json содержит Termux-пути в `env` (`TMPDIR=/data/data/...`). На Windows нужно поправить на `%TEMP%` или удалить env целиком (Windows TMPDIR работает по умолчанию).
- **Лишний клон:** если в projects/ есть отдельная папка `-memory` — она лишняя, хуки найдут `C--Users-Admin/memory`.

**Why:** Пользователь работает на desktop (Windows) + mobile (Termux), хочет единое окружение.
**How to apply:** Полностью решено. На новом устройстве: clone → sync.sh pull → провайдер → restart.
>>>>>>> 6ca6fe7 (Memory update: 2026-06-14 21:52)
