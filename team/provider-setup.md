---
name: Active AI providers
description: AI провайдеры на 2026-06-07: DeepSeek-V4-Pro (685B), Mistral-Small-4 (119B), MiniMax-M2.7, Gemma-4, HuggingFace Inference API
---

**Active AI providers (2026-06-07):**

1. **DeepSeek** (через HF) — `deepseek-ai/DeepSeek-V4-Pro` (862B), `DeepSeek-R1` (685B)
2. **Mistral** (через HF) — `mistralai/Mistral-Small-4-119B-2603` (119B), `Mistral-Medium-3.5-128B`, `Mistral-Nemo-Instruct-2407` (12B)
3. **MiniMax** (через HF) — `MiniMaxAI/MiniMax-M2.7` (139B), `MiniMax-M2.5`
4. **Google** (через HF) — `google/gemma-4-26B-A4B-it` (27B MoE), `gemma-4-31B-it` (34B)
5. **Meta** (через HF) — `meta-llama/Meta-Llama-3.1-405B-Instruct` (405B)
6. **Gitlawb Opengateway** — `mimo-v2.5-pro` / `minimax/minimax-m3`
7. **NVIDIA NIM** — `nvidia/llama-3.1-nemotron-70b-instruct`
8. **Bluesminds** — `qwen/qwen3.5-397b-a17b`
9. **DeepSeek** (прямой) — `deepseek-v4-pro`

**Hugging Face Inference API:**
- Base URL: `https://api-inference.huggingface.co/v1`
- Provider: `openai` (OpenAI-совместимый)
- Токен: типа "Read" с inference правами (https://huggingface.co/settings/tokens)

**How to switch:**
- `/provider` — cycle through configured providers
- `/model <id>` — switch model within current provider

**Configuration location:** `.openclaude.json` + `.openclaude-profile.json` (OpenAI-compatible format).
