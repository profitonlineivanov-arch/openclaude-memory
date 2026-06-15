---
name: Gemma 4 Local Setup
description: Gemma 4 installed locally via Ollama (gemma4:e4b, 9.6 GB), connected as OpenClaude provider "Ollama Local"
type: project
---

Gemma 4 установлена локально через Ollama и подключена как провайдер в OpenClaude (2026-06-15).

**Model:** gemma4:e4b (c6eb396dbd59), 9.6 GB, Ollama.
**Provider:** "Ollama Local" — openai-compatible, baseUrl `http://localhost:11434/v1`, apiKey `ollama`.

**Why:** Хочет запускать модель локально, без зависимости от API-провайдеров.

**How to apply:** Переключение через `/provider` → "Ollama Local". Ollama должна быть запущена (`ollama serve` или через десктопный клиент). Прямой запуск тоже работает: `ollama run gemma4:e4b`.
