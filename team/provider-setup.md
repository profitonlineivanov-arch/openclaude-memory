---
name: Active AI providers
description: 4 AI провайдера ВОССТАНОВЛЕНЫ 2026-06-14: Gitlawb Opengateway, DeepSeek, NVIDIA NIM, Bluesminds. DeepSeek активен на Windows, Gitlawb на Termux.
---

**Active AI providers (2026-06-14, ВОССТАНОВЛЕНЫ из configs/):**

1. **Gitlawb Opengateway** — `mimo-v2.5-pro` (default), endpoint `https://opengateway.gitlawb.com/v1` — активен на Termux
2. **DeepSeek** — `deepseek-v4-pro`, endpoint `https://api.deepseek.com/v1` — активен на Windows
3. **NVIDIA NIM** — `nvidia/llama-3.1-nemotron-70b-instruct`, endpoint `https://integrate.api.nvidia.com/v1`, бесплатный (40 запр/мин)
4. **Bluesminds** — `qwen/qwen3.5-397b-a17b` (397B), endpoint `https://api.bluesminds.com/v1`, медленный (30s+ таймауты)

**Конфигурация:** `.openclaude.json` (все профили) + `.openclaude-profile.json` (активный).
**Синхронизация:** `configs/` в GitHub-репо → `sync.sh pull` (но может потребоваться ручной `cp`).

<<<<<<< HEAD
**Важно:** У каждого провайдера СВОЙ список моделей. После смены провайдера через `/provider` — проверить модель через `/model`.
=======
**New device bootstrap:** Начинать с DeepSeek — дешевле всех, стабильный, `deepseek-v4-pro`. Достаточно одного провайдера для старта.

**How to switch:**
- `/provider` — cycle through configured providers
- `/model <id>` — switch model within current provider (осторожно: не ставить модель от другого провайдера)

**Configuration location:** `.openclaude.json` (все профили) + `.openclaude-profile.json` (активный).
>>>>>>> 6ca6fe7 (Memory update: 2026-06-14 21:52)
