---
name: NVIDIA NIM provider (active)
description: Active AI provider is NVIDIA NIM (since 2026-06-06), OpenAI-compatible format via .openclaude-profile.json
---

**Active AI provider:** NVIDIA NIM (switched 2026-06-06, from DeepSeek).

**Configuration location:** `.openclaude/.openclaude-profile.json`
- `OPENAI_BASE_URL`: `https://integrate.api.nvidia.com/v1`
- `OPENAI_MODEL`: `nvidia/nemotron-3-ultra-550b-a55b`
- Free tier: 40 requests/minute

OpenClaude uses OpenAI-compatible API format, so any OpenAI-compatible provider (NVIDIA NIM, Groq, Together, etc.) can be connected directly — no LiteLLM proxy needed.

**MiniMax M3:** Пытался подключить 2026-06-06, но MiniMax — отдельный провайдер, не совместим с NVIDIA NIM. Требует переключения.

**Previous providers:** DeepSeek (`api.deepseek.com/v1`, `deepseek-v4-pro`), Gitlawb Opengateway.