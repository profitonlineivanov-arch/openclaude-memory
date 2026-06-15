---
name: OpenClaude Provider Architecture
description: Two-file config: .openclaude.json (all providers) + .openclaude-profile.json (active). Recovery: backups/ or configs/ in memory repo from other device.
type: reference
---

OpenClaude использует **OpenAI-совместимый формат API**.

## Двухфайловая система конфигурации

1. **`.openclaude.json`** — ВСЕ профили провайдеров (`providerProfiles`), история, настройки, `mcpServers`
2. **`.openclaude-profile.json`** — только ТЕКУЩИЙ активный провайдер (env: OPENAI_BASE_URL, OPENAI_MODEL, OPENAI_API_KEY)

## Три пути восстановления при потере

**Путь 1 — бэкапы:** `ls -lt .openclaude/backups/` → `cp backups/<latest> .openclaude/.openclaude.json`
- Бесполезны если ВСЕ бэкапы созданы ПОСЛЕ потери (firstStartTime = сегодня)

**Путь 2 — configs/ в memory-репо:** `cd memory && bash sync.sh pull && cp configs/.openclaude.json ~/.openclaude.json`
- Работает если другая машина запушила полный конфиг в `configs/`
- `sync.sh pull` подтягивает `configs/` из GitHub, но `copy_configs_to_oc` может молча провалиться (файл заблокирован процессом)

**Путь 3 — ручное пересоздание:** через `/provider` или редактирование `.openclaude.json`

## Активные провайдеры (2026-06-14):

| Провайдер | Модель | Активен |
|-----------|--------|---------|
| DeepSeek | deepseek-v4-pro | Windows |
| Gitlawb Opengateway | mimo-v2.5-pro | Termux |
| NVIDIA NIM | nvidia/llama-3.1-nemotron-70b-instruct | — |
| Bluesminds | qwen/qwen3.5-397b-a17b | — |

## Важно: модели привязаны к провайдерам

После смены провайдера через `/provider` — проверить модель через `/model`. Модель от предыдущего провайдера может вызвать API-ошибку.
