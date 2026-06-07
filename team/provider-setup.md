---
name: Gitlawb Opengateway provider (active)
description: Active AI provider is Gitlawb Opengateway (switched 2026-06-07), model mimo-v2.5-pro (or minimax/minimax-m3). OpenAI-compatible format via .openclaude-profile.json
---

**Active AI provider:** Gitlawb Opengateway (switched 2026-06-07).

**Active model:** `minimax/minimax-m3` (set 2026-06-07 via `/model` command, while provider is Gitlawb Opengateway).
- Alternative model on same provider: `mimo-v2.5-pro` (default after `/provider` switch)

**How to switch:**
- `/provider` — switch to Gitlawb Opengateway
- `/model minimax/minimax-m3` — switch model within provider

**Configuration location:** `.openclaude/.openclaude-profile.json` (OpenAI-compatible format).

OpenClaude uses OpenAI-compatible API format, so any OpenAI-compatible provider can be connected directly — no LiteLLM proxy needed.

**Previous providers:** NVIDIA NIM (2026-06-06, `nvidia/nemotron-3-ultra-550b-a55b`), DeepSeek (`api.deepseek.com/v1`, `deepseek-v4-pro`).

**Note on MiniMax M3:** Earlier believed to require separate provider + device flow (see minimax-m3-provider.md). On 2026-06-07 user confirmed it works via Gitlawb Opengateway under identifier `minimax/minimax-m3` — no device flow needed.