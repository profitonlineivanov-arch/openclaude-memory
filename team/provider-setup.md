---
name: DeepSeek provider
description: Project uses DeepSeek as the active AI provider (configured via /provider command)
type: reference
---

Active AI provider is **NVIDIA NIM** (switched from DeepSeek 2026-06-06). Previously used "Gitlawb Opengateway" → DeepSeek → NVIDIA NIM.

**Configuration location:** `.openclaude/.openclaude-profile.json`
- `OPENAI_BASE_URL`: `https://integrate.api.nvidia.com/v1`
- `OPENAI_MODEL`: `nvidia/nemotron-3-ultra-550b-a55b`
- Free tier: 40 requests/minute

OpenClaude uses OpenAI-compatible API format, so any OpenAI-compatible provider (NVIDIA NIM, Groq, Together, etc.) can be connected directly — no LiteLLM proxy needed.

**Previous providers:** DeepSeek (`api.deepseek.com/v1`, `deepseek-v4-pro`), Gitlawb Opengateway.
