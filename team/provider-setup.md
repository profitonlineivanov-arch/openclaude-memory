---
name: Active AI providers
description: Multiple active AI providers as of 2026-06-07: Gitlawb Opengateway (mimo-v2.5-pro/minimax-minimax-m3), NVIDIA NIM (llama-3.1-nemotron-70b-instruct), DeepSeek (deepseek-v4-pro), Bluesminds (qwen3.5-397b). OpenAI-compatible format.
---

**Active AI providers (2026-06-07):** Multiple providers confirmed working, switchable via `/provider` and `/model`:

1. **DeepSeek** — `deepseek-v4-pro` (использован 2026-06-07)
2. **Gitlawb Opengateway** — `mimo-v2.5-pro` (default) / `minimax/minimax-m3`
3. **NVIDIA NIM** — `nvidia/llama-3.1-nemotron-70b-instruct` (использован 2026-06-07)
4. **Bluesminds** — `qwen/qwen3.5-397b-a17b` (trial tier)

**How to switch:**
- `/provider` — cycle through configured providers
- `/model <id>` — switch model within current provider

**Configuration location:** `.openclaude/.openclaude-profile.json` (OpenAI-compatible format).

OpenClaude uses OpenAI-compatible API format, so any OpenAI-compatible provider can be connected directly — no LiteLLM proxy needed.
