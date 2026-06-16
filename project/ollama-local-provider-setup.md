---
name: Ollama Local Provider Setup
description: RTX 3050 8GB — qwen2.5:7b работает, 14b удалён. 4 модели в Ollama, qwen2.5:7b активна для OpenClaude.
type: project
---

**Готово (2026-06-16):**
- qwen2.5:7b установлен (4.7 GB) — влезает в RTX 3050 8GB
- qwen2.5:14b удалён — Vulkan allocation fail (нужно ~10 GB buffer, есть только 8 GB)
- Провайдер "Ollama Local" в .openclaude.json использует qwen2.5:7b
- `/provider` → "Ollama Local" работает

**Ограничение:** Максимум ~7 GB на модель из-за Vulkan-оверхеда. Более агрессивные кванты (Q3, Q2) не стоят потери качества — 7b Q4_K_M > 14b Q2.

**Why:** qwen2.5:14b не влезал в VRAM, ошибка `alloc_tensor_range: failed to allocate Vulkan0 buffer of size 1046986752`.
**How to apply:** Провайдер настроен, переключение через `/provider`.
