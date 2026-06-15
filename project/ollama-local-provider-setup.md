---
name: Ollama Local Provider Setup
description: RTX 3050 8GB — qwen2.5:7b (4.7GB) fits, 14b doesn't. Need to switch provider model to 7b.
type: project
---

Ollama Local провайдер добавлен в .openclaude.json, но qwen2.5:14b не влезает в VRAM RTX 3050 Laptop (8 GB).

**Next step:** заменить модель в провайдере на `qwen2.5:7b` (~4.7 GB).

**Why:** 14b = 9 GB > 8 GB VRAM, Vulkan allocation fails.

**How to apply:** `ollama pull qwen2.5:7b`, then edit .openclaude.json provider_ollama_local model field.
