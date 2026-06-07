---
name: Hugging Face Provider
description: HF — УДАЛЁН из конфига (2026-06-07). DNS + биллинг. Если вернуть — router.huggingface.co/v1 + карта в HF.
type: reference
---

## Hugging Face — УДАЛЁН (2026-06-07)

**Причины:**
1. Старый serverless endpoint `api-inference.huggingface.co` — DNS не резолвится
2. Новый router `router.huggingface.co` — требует биллинг. Free tier $0.10/мес (бессмысленно)

**Если понадобится:** привязать карту в HF → router заработает. Endpoint: `https://router.huggingface.co/v1`
