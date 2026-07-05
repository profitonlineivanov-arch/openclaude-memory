---
name: ZenMux Provider Setup
description: ZenMux (zenmux.ai) провайдер: бесплатные модели z-ai/glm-5.2-free, moonshotai/kimi-k2.7-code-free. OpenAI-совместимый API. API key есть (2026-06-19).
type: project
---

ZenMux — OpenAI-совместимый провайдер с бесплатными моделями:
- z-ai/glm-5.2-free
- moonshotai/kimi-k2.7-code-free

API endpoint: `https://zenmux.ai/api/v1/chat/completions`
Authorization: `Bearer $ZENMUX_API_KEY`

Пример curl:
```bash
curl https://zenmux.ai/api/v1/chat/completions \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $ZENMUX_API_KEY" \
-d '{"model":"z-ai/glm-5.2-free","messages":[{"role":"user","content":"test"}]}'
```

Статус: API key получен, провайдер добавлен в .openclaude.json (2026-06-19).

**Why:** Бесплатные модели для экономии токенов.

**How to apply:** Использовать baseUrl `https://zenmux.ai/api/v1`, provider `openai`, model `z-ai/glm-5.2-free` или `moonshotai/kimi-k2.7-code-free`.
