---
name: Bluesminds Provider Setup
description: Bluesminds ПОДКЛЮЧЁН 2026-06-07 — Qwen 3.5 397B работает, но бывают таймауты (30s+), OpenAI-совместимый.
type: reference
---

**Bluesminds** — облачный AI-провайдер с trial-моделями. OpenAI-совместимый API.

**Endpoint:** `https://api.bluesminds.com/v1`
**Статус (2026-06-07):** ПОДКЛЮЧЁН, работает. API проверен curl-ом дважды — первый раз таймаут (exit code 28, >15s), второй раз с 30s таймаутом ответил "Hi there!" за 307ms. Провайдер рабочий, но нестабильный — требует увеличенных таймаутов.

**Важно:** Bluesminds появляется в `/provider` только если запись есть в `.openclaude.json`. Если файл удалён — `/provider` зависнет на 30 секунд (см. `feedback/dot-openclaude-json-missing.md`).

**Активная модель:** `qwen/qwen3.5-397b-a17b` (397B параметров, 17B активных)

**Проверенные работающие модели (2026-06-07):**

| Модель | Параметры | Статус |
|--------|-----------|--------|
| qwen/qwen3.5-397b-a17b | 397B (17B active) | OK (проверен 2026-06-07 chat completion) |
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

## Важно: не менять модель через /model на несуществующую

**Симптом:** "API Error: Please wait a moment and try again."

**Причина:** `/model` устанавливает модель глобально, но у каждого провайдера свой список моделей. Если после переключения на Bluesminds модель осталась `GPT-5.5 mini` (от другого провайдера) — Bluesminds вернёт ошибку.

**Исправление:** `/model qwen/qwen3.5-397b-a17b` — вернуть правильную модель Bluesminds.
