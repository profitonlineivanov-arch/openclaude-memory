---
name: Bluesminds Provider Setup
description: Bluesminds — ВОССТАНОВЛЕН 2026-06-14 из configs/ в memory-репо. Qwen 3.5 397B, OpenAI-совместимый, таймауты 30s+.
type: reference
---

**Bluesminds** — облачный AI-провайдер с trial-моделями. OpenAI-совместимый API.

**Endpoint:** `https://api.bluesminds.com/v1`
**Статус (2026-06-14):** ВОССТАНОВЛЕН — конфиг подтянут из `configs/` memory-репо (другая машина запушила). Не нужно пересоздавать.

**Активная модель:** `qwen/qwen3.5-397b-a17b` (397B параметров, 17B активных) — переключено через `/provider` (2026-06-17)

**Конфиг в `.openclaude.json`:**
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

**Проверенные работающие модели:**
| Модель | Параметры | Статус |
|--------|-----------|--------|
| qwen/qwen3.5-397b-a17b | 397B (17B active) | OK |
| qwen3.6-27b | 27B | OK |
| z-ai/glm-5.1 | — | OK |
| gemini-3.1-pro | — | OK |
| accounts/fireworks/models/deepseek-v4-pro | — | OK |

**Важно:** Таймауты 30s+. Нестабилен. После смены провайдера — проверить модель через `/model`.
