---
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
