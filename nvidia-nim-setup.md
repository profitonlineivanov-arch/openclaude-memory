---
name: NVIDIA NIM Setup
description: NVIDIA NIM — активный провайдер. Подключался 2026-06-06 (nemotron-3-ultra) и 2026-06-07 (llama-3.1-nemotron-70b-instruct).
type: reference
---

**NVIDIA NIM** — облачный сервис с бесплатным тарифом (40 запросов/мин). OpenAI-совместимый API.

**Endpoint:** `https://integrate.api.nvidia.com/v1`
**Статус (2026-06-07):** АКТИВЕН. Использован повторно 2026-06-07 с моделью `nvidia/llama-3.1-nemotron-70b-instruct`. Ранее (2026-06-06) использовался `nvidia/nemotron-3-ultra-550b-a55b`.

**Доступные модели (2026-06-07):** `/model` показал `nvidia/llama-3.1-nemotron-70b-instruct` как доступную.

**Бесплатные модели (2026-06-06):**

| Модель | Параметры | Контекст | Макс. вывод |
|--------|-----------|----------|-------------|
| Nemotron 3 Ultra | 550B (55B активных) | 1,000,000 | 16,384 |
| Nemotron 3 Super | 120B (12B активных) | 262,144 | 8,192 |
| Kimi K2.5 | — | 262,144 | 8,192 |
| Minimax M2.7 | — | 196,608 | 8,192 |
| GLM 5.1 | — | 202,752 | 8,192 |

**Документация NVIDIA:** https://docs.nvidia.com/nim/large-language-models/latest/ai-assistant-integrations/claude-code.html
**Каталог моделей:** https://build.nvidia.com/models
