---
name: Bluesminds Provider Setup
description: Bluesminds ПОДКЛЮЧЁН 2026-06-07 — Qwen 3.5 397B, OpenAI-совместимый, trial-модели
type: reference
---

**Bluesminds** — облачный AI-провайдер с trial-моделями. OpenAI-совместимый API.

**Endpoint:** `https://api.bluesminds.com/v1`
**Статус (2026-06-07):** ПОДКЛЮЧЁН. Добавлен в `.openclaude.json` как provider_b1d2e3f4a5b6 (provider: "openai"). Требуется рестарт OpenClaude для появления в `/provider`.

**Активная модель:** `qwen/qwen3.5-397b-a17b` (397B параметров, 17B активных)

**Проверенные работающие модели (2026-06-07):**

| Модель | Параметры | Статус |
|--------|-----------|--------|
| qwen/qwen3.5-397b-a17b | 397B (17B active) | OK |
| qwen3.6-27b | 27B | OK |
| z-ai/glm-5.1 | — | OK |
| gemini-3.1-pro | — | OK |
| accounts/fireworks/models/deepseek-v4-pro | — | OK |
| stepfun-ai/step-3.5-flash | — | OK |
| race:moonshotai/kimi-k2.5\|qwen/qwen3.5-397b-a17b | — | OK |

**НЕработающие модели:**
- `kimi-k2.5`, `moonshotai/kimi-k2.5` — model_not_found
- `minimax-m2` — model_not_found
- `gpt-4o-mini` — Invalid model name

**API ключ:** `sk-11jvXszGwDVJfKXClM4w2Um89JRecjoM2vAVoaDwMcfJCbFT`
