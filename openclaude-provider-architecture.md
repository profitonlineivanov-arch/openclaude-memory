---
name: OpenClaude Provider Architecture
description: OpenClaude использует OpenAI-совместимый формат API (не Anthropic), конфигурация в .openclaude/.openclaude-profile.json. Три активных провайдера на 2026-06-07.
type: reference
---

OpenClaude использует **OpenAI-совместимый формат API**, а не нативный Anthropic формат. Это значит, что любой OpenAI-совместимый провайдер можно подключить напрямую, без прокси вроде LiteLLM.

**Конфигурация провайдера** хранится в `.openclaude/.openclaude-profile.json`:
- `OPENAI_BASE_URL` — endpoint провайдера
- `OPENAI_API_KEY` — API ключ
- `OPENAI_MODEL` — имя модели

**Активные провайдеры (2026-06-07):**
1. **DeepSeek** — `deepseek-v4-pro`, endpoint `https://api.deepseek.com/v1`
2. **Gitlawb Opengateway** — `mimo-v2.5-pro` / `minimax/minimax-m3`
3. **NVIDIA NIM** — `nvidia/llama-3.1-nemotron-70b-instruct`, endpoint `https://integrate.api.nvidia.com/v1`
4. **Bluesminds** — `qwen/qwen3.5-397b-a17b`, endpoint `https://api.bluesminds.com/v1`

Все четыре провайдера подтверждены рабочими. Переключение через `/provider` и `/model`.

**Следствия:**
- Любой OpenAI-совместимый API (Groq, Together, local LLM) должен работать аналогично
- Не нужно устанавливать `ANTHROPIC_BASE_URL` — используется `OPENAI_BASE_URL`
