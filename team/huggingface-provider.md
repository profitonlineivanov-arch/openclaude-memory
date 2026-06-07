---
name: Hugging Face Provider
description: Hugging Face Inference API — каталог топových моделей: DeepSeek-V4-Pro (862B), Mistral-Small-4 (119B), Gemma-4 (27B), MiniMax-M2.7 (2026-06-07)
type: reference
---

**Hugging Face Inference API — каталог моделей (2026-06-07)**

**Конфигурация:**
- **Provider:** `openai` (OpenAI-совместимый формат)
- **Base URL:** `https://api-inference.huggingface.co/v1`

**Топовые модели по производителям:**

| Производитель | Модель | Параметры |
|--------------|--------|-----------|
| **DeepSeek** | `deepseek-ai/DeepSeek-V4-Pro` | 862B |
| **DeepSeek** | `deepseek-ai/DeepSeek-R1` | 685B |
| **Mistral** | `mistralai/Mistral-Small-4-119B-2603` | 119B |
| **Mistral** | `mistralai/Mistral-Medium-3.5-128B` | 128B |
| **Mistral** | `mistralai/Mistral-Nemo-Instruct-2407` | 12B |
| **MiniMax** | `MiniMaxAI/MiniMax-M2.7` | 139B |
| **Google** | `google/gemma-4-26B-A4B-it` | 27B (MoE) |
| **Google** | `google/gemma-4-31B-it` | 34B |
| **Meta** | `meta-llama/Meta-Llama-3.1-405B-Instruct` | 405B |
| **Meta** | `meta-llama/Meta-Llama-3.1-70B-Instruct` | 70B |

**Как переключиться на модель HF:**
1. Обновить `model` в `providerProfiles` (.openclaude.json)
2. Или использовать `/model <id>`

**Получение токена:** https://huggingface.co/settings/tokens (токен типа "Read" с правами на inference)