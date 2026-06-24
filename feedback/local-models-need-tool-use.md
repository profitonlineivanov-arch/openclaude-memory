---
name: Local models need tool use
description: Ollama local models must support tool use to work as OpenClaude providers. Gemma 4 failed despite tool use support; qwen2.5:7b works; qwen2.5:14b removed due to VRAM (not tool use)
type: feedback
---

Локальные модели через Ollama НЕ работают как провайдеры OpenClaude без поддержки tool use.

**Модели с tool use (из Ollama):**
- `qwen2.5:14b` — ✅ tools, ❌ thinking, 9 GB — **НЕ влезает в RTX 3050 8GB** (Vulkan alloc fail)
- `qwen2.5-coder:7b` — ✅ tools, ❌ thinking, 4.7 GB — **работает**
- `gemma4:e4b` — ✅ tools, ✅ thinking, 9.6 GB — **НЕ работает** (зацикливается, генерирует мусор до 32k)
- `starcoder2:7b` — ❌ tools — **НЕ подходит**

**Рабочая модель:** qwen2.5:7b / qwen2.5-coder:7b (поддержка tool use + влезает в VRAM).

**Why:** Проблема Gemma 4 — не отсутствие tool use (она его поддерживает), а что-то другое (thinking mode? формат?). qwen2.5:14b удалена чисто из-за VRAM.

**How to apply:** Проверять tool use поддержку + размер модели перед установкой. Модели >7 GB не влезут в RTX 3050 8GB.
