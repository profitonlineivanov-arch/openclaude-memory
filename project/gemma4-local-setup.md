---
name: Gemma 4 Local Setup
description: Gemma 4 installed via Ollama (gemma4:e4b, 9.6 GB) — НЕ работает как OpenClaude провайдер (нет tool use)
type: project
---

Gemma 4 установлена локально через Ollama (2026-06-15), НО НЕ РАБОТАЕТ как провайдер OpenClaude.

**Model:** gemma4:e4b (c6eb396dbd59), 9.6 GB, Ollama.
**Provider:** "Ollama Local" добавлен в .openclaude.json (provider_ollama_local) — openai-compatible, baseUrl `http://localhost:11434/v1`, apiKey `ollama`.

**Problem:** Gemma 4 не поддерживает tool use (function calling). При подключении через OpenClaude модель зацикливается и генерирует мусор до 32k output token лимита. Ошибка: "Claude's response exceeded the 32000 output token maximum".

**Why:** Хотел запускать модель локально, без зависимости от API-провайдеров.

**How to apply:** НЕ использовать Gemma 4 для OpenClaude. Для локальной работы нужны модели с tool use: llama3.1, qwen2.5, mistral-nemo. Даже они будут значительно слабее cloud провайдеров. Ollama провайдер в конфиге можно оставить — переключение через `/provider` → "Ollama Local". Замена: qwen2.5:14b установлен (9.0 GB), провайдер обновлён на qwen2.5:14b (2026-06-15).
