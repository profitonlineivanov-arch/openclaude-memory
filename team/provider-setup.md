---
name: Active AI providers
description: AI провайдеры на 2026-06-08: Gitlawb Opengateway (текущий) + DeepSeek, Bluesminds, NVIDIA NIM. HuggingFace удалён.
---

**Active AI providers (2026-06-08):**

1. **Gitlawb Opengateway** (текущий) — `minimax/minimax-m3` (default), `mimo-v2.5-pro` (альтернатива), endpoint `https://opengateway.gitlawb.com/v1`
2. **DeepSeek** — `deepseek-v4-pro`, endpoint `https://api.deepseek.com/v1`
3. **Bluesminds** — `qwen/qwen3.5-397b-a17b` (397B), endpoint `https://api.bluesminds.com/v1`, медленный (30s+ таймауты)
4. **NVIDIA NIM** — `nvidia/llama-3.3-nemotron-super-49b-v1` (49B), endpoint `https://integrate.api.nvidia.com/v1`, бесплатный (40 запр/мин)
5. **Hugging Face** — УДАЛЁН: DNS-блокировка + биллинг $0.10/мес (2026-06-07)

**Важно:** У каждого провайдера СВОЙ список моделей. `/model` устанавливает модель глобально — после смены провайдера модель от предыдущего может вызвать API-ошибку.

**New device bootstrap:** Начинать с DeepSeek — дешевле всех, стабильный, `deepseek-v4-pro`. Достаточно одного провайдера для старта. НО: если есть доступ к configs/ через sync.sh pull, все 4 провайдера восстановятся автоматически (2026-06-14 подтверждено на Windows ноуте).

**How to switch:**
- `/provider` — cycle through configured providers
- `/model <id>` — switch model within current provider (осторожно: не ставить модель от другого провайдера)

**Configuration location:** `.openclaude.json` (все профили) + `.openclaude-profile.json` (активный).
