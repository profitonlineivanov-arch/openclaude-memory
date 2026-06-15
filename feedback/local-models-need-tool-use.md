---
name: Local models need tool use
description: Ollama local models without tool use (Gemma 4 etc.) fail as OpenClaude providers — quantization doesn't help, only tool-use-capable models work
type: feedback
---

Локальные модели через Ollama НЕ работают как провайдеры OpenClaude без поддержки tool use.

**Why:** Gemma 4 (gemma4:e4b) зациклилась при первом же запросе — генерировала мусор до 32k output token лимита. Модель не понимает формат tool use (Claude Code протокол). Вся линейка Gemma (2, 3, 4) от Google НЕ поддерживает tool use. Единственные модели Google с tool use — Gemini (только cloud). LM Studio — просто другой рантайм, та же проблема (спрашивали 2026-06-15).

**How to apply:** Проблема в формате tool use, не в размере модели и не в рантайме (Ollama/LM Studio/vLLM). Квантирование не помогает. Gemma 3 26B — тоже не работает. qwen2.5:14b (9.0 GB) УСТАНОВЛЕН но тоже НЕ работает в OpenClaude (2026-06-15, пользователь подтвердил). Локальные модели через Ollama/OpenAI-compatible API не поддерживают tool use в формате, который ожидает OpenClaude. Остаться на cloud провайдерах (Gitlawb Opengateway, DeepSeek, NVIDIA NIM, Bluesminds).
