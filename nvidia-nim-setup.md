---
name: NVIDIA NIM Setup
description: NVIDIA NIM ПОДКЛЮЧЁН 2026-06-06 — Nemotron 3 Ultra 550B, OpenAI-совместимый, 40 req/min бесплатно
type: reference
---

**NVIDIA NIM** — облачный сервис с бесплатным тарифом (40 запросов/мин). OpenAI-совместимый API.

**Endpoint:** `https://integrate.api.nvidia.com/v1`
**Статус (2026-06-06):** ПОДКЛЮЧЁН. Профиль обновлён в `.openclaude/.openclaude-profile.json`. Требуется рестарт OpenClaude для применения.

**Активная модель:** `nvidia/nemotron-3-ultra-550b-a55b` (550B параметров, 55B активных)

**Бесплатные модели (2026-06-06):**

| Модель | Параметры | Контекст | Макс. вывод |
|--------|-----------|----------|-------------|
| Nemotron 3 Ultra | 550B (55B активных) | 1,000,000 | 16,384 |
| Nemotron 3 Super | 120B (12B активных) | 262,144 | 8,192 |
| Kimi K2.5 | — | 262,144 | 8,192 |
| Minimax M2.7 | — | 196,608 | 8,192 |
| GLM 5.1 | — | 202,752 | 8,192 |

**Подключение к OpenClaude (прямое, без LiteLLM):**
OpenClaude использует OpenAI-совместимый формат, поэтому достаточно заменить значения в `.openclaude/.openclaude-profile.json`:
- `OPENAI_BASE_URL` → `https://integrate.api.nvidia.com/v1`
- `OPENAI_API_KEY` → `nvapi-...`
- `OPENAI_MODEL` → `nvidia/nemotron-3-ultra-550b-a55b`

И обновить `"model"` в `settings.json`.

**Документация NVIDIA:** https://docs.nvidia.com/nim/large-language-models/latest/ai-assistant-integrations/claude-code.html
**Каталог моделей:** https://build.nvidia.com/models
