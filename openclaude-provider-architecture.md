---
name: OpenClaude Provider Architecture
description: OpenClaude использует OpenAI-совместимый формат API (не Anthropic), конфигурация в .openclaude/.openclaude-profile.json. Текущий провайдер: Bluesminds (2026-06-07).
type: reference
---

OpenClaude использует **OpenAI-совместимый формат API**, а не нативный Anthropic формат. Это значит, что любой OpenAI-совместимый провайдер можно подключить напрямую, без прокси вроде LiteLLM.

**Конфигурация провайдера** хранится в `.openclaude/.openclaude-profile.json`:
- `OPENAI_BASE_URL` — endpoint провайдера
- `OPENAI_API_KEY` — API ключ
- `OPENAI_MODEL` — имя модели

**Текущий провайдер (2026-06-07):** Bluesminds
- Base URL: `https://api.bluesminds.com/v1`
- Model: `qwen/qwen3.5-397b-a17b`
- Trial/free tier

**История провайдеров:**
1. DeepSeek (`https://api.deepseek.com/v1`, `deepseek-v4-pro`) — до 2026-06-07
2. NVIDIA NIM (`https://integrate.api.nvidia.com/v1`, `nvidia/nemotron-3-ultra-550b-a55b`) — 2026-06-06
3. Gitlawb Opengateway (`mimo-v2.5-pro` / `minimax/minimax-m3`) — 2026-06-07

**Следствия:**
- Любой OpenAI-совместимый API (Groq, Together, local LLM) должен работать аналогично
- Не нужно устанавливать `ANTHROPIC_BASE_URL` — используется `OPENAI_BASE_URL`
