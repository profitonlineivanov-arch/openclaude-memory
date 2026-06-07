---
name: NVIDIA NIM Setup
description: NVIDIA NIM — АКТИВЕН: llama-3.3-nemotron-super-49b-v1 работает, llama-3.1-nemotron-70b НЕ работает (требует деплоя)
type: reference
---

**NVIDIA NIM** — облачный сервис с бесплатным тарифом (40 запросов/мин). OpenAI-совместимый API.

**Endpoint:** `https://integrate.api.nvidia.com/v1`
**Статус (2026-06-07):** РАБОТАЕТ с моделью `nvidia/llama-3.3-nemotron-super-49b-v1` (49B). Модель `nvidia/llama-3.1-nemotron-70b-instruct` НЕ работает — требует деплоя "function" в аккаунте (404 "Function not found for account").

**Работающие модели (проверено 2026-06-07):**
| Модель | Статус |
|--------|--------|
| `nvidia/llama-3.3-nemotron-super-49b-v1` | OK |
| `nvidia/llama-3.1-nemotron-70b-instruct` | 404 — требует деплоя |
| `nvidia/nemotron-3-ultra-550b-a55b` | Timeout |
| `nvidia/nemotron-3-super-120b-a12b` | Не проверен |

**Документация NVIDIA:** https://docs.nvidia.com/nim/large-language-models/latest/ai-assistant-integrations/claude-code.html
**Каталог моделей:** https://build.nvidia.com/models
