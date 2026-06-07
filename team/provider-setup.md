---
name: Active AI providers
description: AI провайдеры на 2026-06-07: DeepSeek, Bluesminds (Qwen 397B), NVIDIA NIM (nemotron-super-49b), Gitlawb Opengateway, HuggingFace (сломан)
---

**Active AI providers (2026-06-07):**

1. **DeepSeek** (прямой) — `deepseek-v4-pro`, endpoint `https://api.deepseek.com/v1`
2. **Bluesminds** — `qwen/qwen3.5-397b-a17b` (397B), endpoint `https://api.bluesminds.com/v1`, медленный (30s+ таймауты)
3. **NVIDIA NIM** — `nvidia/llama-3.3-nemotron-super-49b-v1` (49B), endpoint `https://integrate.api.nvidia.com/v1`, бесплатный (40 запр/мин)
4. **Gitlawb Opengateway** — `mimo-v2.5-pro` / `minimax/minimax-m3`, endpoint `https://opengateway.gitlawb.com/v1`
5. **Hugging Face** — СЛОМАН: 2 проблемы — старый endpoint DNS-блокировка + router требует биллинга (токен валидный, 10 моделей сохранены)

**Важно:** У каждого провайдера СВОЙ список моделей. `/model` устанавливает модель глобально — после смены провайдера модель от предыдущего может вызвать API-ошибку.

**How to switch:**
- `/provider` — cycle through configured providers
- `/model <id>` — switch model within current provider (осторожно: не ставить модель от другого провайдера)

**Configuration location:** `.openclaude.json` (все профили) + `.openclaude-profile.json` (активный).
