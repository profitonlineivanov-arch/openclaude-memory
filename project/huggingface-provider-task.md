---
name: Hugging Face Provider Task
description: Подключение Hugging Face Inference API как провайдера (2026-06-07)
type: project
---

Пользователь хочет подключить Hugging Face Inference API как провайдер (по аналогии с NVIDIA NIM и Bluesminds) — 2026-06-07.

**Формат:** OpenAI-совместимый (`provider: "openai"`)
**Базовый URL:** `https://api-inference.huggingface.co/v1`

**Требуется:**
- API токен HF (https://huggingface.co/settings/tokens, тип "Read" с правами на inference)
- Выбрать модель (популярные: `meta-llama/Meta-Llama-3.1-70B-Instruct`, `mistralai/Mistral-Large-2407`, `Qwen/Qwen2.5-72B-Instruct`)

**How to apply:** При подключении добавить в `.openclaude.json` новый `providerProfiles` entry + обновить `.openclaude-profile.json` для активации.