---
name: OpenClaude Provider Architecture
description: OpenClaude использует OpenAI-совместимый формат API (не Anthropic), конфигурация в .openclaude/.openclaude-profile.json
type: reference
---

OpenClaude использует **OpenAI-совместимый формат API**, а не нативный Anthropic формат. Это значит, что любой OpenAI-совместимый провайдер можно подключить напрямую, без прокси вроде LiteLLM.

**Конфигурация провайдера** хранится в `.openclaude/.openclaude-profile.json`:
- `OPENAI_BASE_URL` — endpoint провайдера
- `OPENAI_API_KEY` — API ключ
- `OPENAI_MODEL` — имя модели

**Текущий провайдер (2026-06-06):** NVIDIA NIM
- Base URL: `https://integrate.api.nvidia.com/v1`
- Model: `nvidia/nemotron-3-ultra-550b-a55b`
- Free tier: 40 req/min

**Предыдущий провайдер:** DeepSeek (`https://api.deepseek.com/v1`, `deepseek-v4-pro`).

**Следствия:**
- NVIDIA NIM подключается напрямую (тоже OpenAI-совместимый) без LiteLLM
- Любой OpenAI-совместимый API (Groq, Together, local LLM) должен работать аналогично
- Не нужно устанавливать `ANTHROPIC_BASE_URL` — используется `OPENAI_BASE_URL`
