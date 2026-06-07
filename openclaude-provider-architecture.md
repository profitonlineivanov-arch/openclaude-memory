---
name: OpenClaude Provider Architecture
description: Two-file config system: .openclaude.json (all providers) + .openclaude-profile.json (active). If .openclaude.json deleted, /provider fails with timeout. Restore from backups/.
type: reference
---

OpenClaude использует **OpenAI-совместимый формат API**, а не нативный Anthropic формат. Это значит, что любой OpenAI-совместимый провайдер можно подключить напрямую, без прокси вроде LiteLLM.

## Двухфайловая система конфигурации

**Два файла, разные роли:**

1. **`.openclaude.json`** — хранит ВСЕ профили провайдеров (`providerProfiles`), историю, настройки. Это главный конфиг.
2. **`.openclaude-profile.json`** — только ТЕКУЩИЙ активный провайдер (env: OPENAI_BASE_URL, OPENAI_MODEL, OPENAI_API_KEY). Перезаписывается при `/provider`.

**Формат провайдера в `.openclaude.json`:**
```json
{
  "id": "provider_b1d2e3f4a5b6",
  "name": "Bluesminds",
  "provider": "openai",
  "baseUrl": "https://api.bluesminds.com/v1",
  "model": "qwen/qwen3.5-397b-a17b",
  "apiKey": "sk-..."
}
```

## Критическая проблема: удаление .openclaude.json

**Симптом:** `/provider` показывает `Topsy-turvying… (30s)` + рекламный tip (Xiaomi MiMo и т.п.)

**Причина:** файл `.openclaude.json` отсутствует или удалён. Без него `/provider` не может найти профили провайдеров и зависает на 30 секунд.

**Исправление:**
1. Проверить: `ls .openclaude/.openclaude.json`
2. Найти последний бэкап: `ls -lt .openclaude/backups/`
3. Восстановить: `cp .openclaude/backups/.openclaude.json.backup.<latest> .openclaude/.openclaude.json`
4. Перезапустить OpenClaude

## Активные провайдеры (2026-06-07):

1. **DeepSeek** — `deepseek-v4-pro`, endpoint `https://api.deepseek.com/v1` (основной)
2. **Gitlawb Opengateway** — `mimo-v2.5-pro` / `minimax/minimax-m3`
3. **NVIDIA NIM** — `nvidia/llama-3.3-nemotron-super-49b-v1`, endpoint `https://integrate.api.nvidia.com/v1`
4. **Bluesminds** — `qwen/qwen3.5-397b-a17b`, endpoint `https://api.bluesminds.com/v1` (медленный)
5. **Hugging Face** — СЛОМАН, endpoint `api-inference.huggingface.co` не резолвится

## Важно: модели привязаны к провайдерам

**Симптом:** "API Error" или "model not found" после смены провайдера.

**Причина:** `/model` устанавливает модель глобально. После переключения провайдера через `/provider`, модель от предыдущего провайдера может остаться активной и вызвать ошибку (например, `GPT-5.5 mini` не существует на Bluesminds).

**Исправление:** После смены провайдера проверить модель через `/model` и установить совместимую.
