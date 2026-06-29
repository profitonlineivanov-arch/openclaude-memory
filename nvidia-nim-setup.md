---
name: NVIDIA NIM Setup
description: NVIDIA NIM — ВОССТАНОВЛЕН 2026-06-14 из configs/ в memory-репо. Модель llama-3.1-nemotron-70b-instruct (configs/ версия). Бесплатно 40 запр/мин.
type: reference
---

**NVIDIA NIM** — облачный сервис с бесплатным тарифом (40 запросов/мин). OpenAI-совместимый API.

**Endpoint:** `https://integrate.api.nvidia.com/v1`
**Статус (2026-06-14):** ВОССТАНОВЛЕН — конфиг с 4 провайдерами подтянут из `configs/` memory-репо (другая машина запушила).
**Модель в конфиге:** `nvidia/llama-3.3-nemotron-super-49b-v1` (переключено обратно 2026-06-16 через `/provider`)
**Другие попробованные модели:** `moonshotai/kimi-k2.6` (через `/model`, 2026-06-16)

**Конфиг в `.openclaude.json`:**
```json
{
  "id": "provider_9b10442e244c",
  "name": "NVIDIA NIM",
  "provider": "nvidia-nim",
  "baseUrl": "https://integrate.api.nvidia.com/v1",
  "model": "nvidia/llama-3.1-nemotron-70b-instruct",
  "apiKey": "nvapi-..."
}
```

**Работающие модели:**
| Модель | Статус |
|--------|--------|
| `nvidia/llama-3.3-nemotron-super-49b-v1` | OK (2026-06-07, 2026-06-16) |
| `nvidia/llama-3.1-nemotron-70b-instruct` | 404 ранее — требует деплоя |
| `moonshotai/kimi-k2.6` | попробован 2026-06-16 через `/model` |

**Ограничение:** Web Search НЕ работает с NVIDIA NIM провайдером — DuckDuckGo scraping rate-limited. Нужен FIRECRAWL_API_KEY / TAVILY_API_KEY / другой search backend, или переключиться на провайдер с встроенным web search (Anthropic, Vertex).

**Документация:** https://docs.nvidia.com/nim/large-language-models/latest/ai-assistant-integrations/claude-code.html
**Каталог:** https://build.nvidia.com/models
