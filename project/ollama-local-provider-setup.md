---
name: Ollama Local Provider Setup
description: RTX 3050 8GB — models on D:\Ollama\models (OLLAMA_MODELS env var). qwen2.5:7b works, 14b removed (VRAM). 4 models installed, ollama list may show empty if service needs restart.
type: project
---

**Местоположение моделей:** `D:\Ollama\models` (User env var `OLLAMA_MODELS=D:\Ollama\models`, System env var НЕ задан).
- Манифесты: `D:\Ollama\models\manifests\registry.ollama.ai/library/` — 4 модели (gemma4:e4b, qwen2.5/7b, qwen2.5-coder/7b, starcoder2/7b)
- Блобы: `D:\Ollama\models\blobs/` — 17 файлов, 22 GB

**Провайдер:** "Ollama Local" в .openclaude.json, переключение через `/provider`.

**Известная проблема:** `ollama list` показывает пустой список. Причина — `OLLAMA_MODELS=D:\Ollama\models` задан как **User** переменная, а Ollama работает в **системном** контексте. Перезапуск НЕ помогает.
**Решение:** Win+I → Система → О системе → Доп. параметры → Переменные среды → добавить `OLLAMA_MODELS` = `D:\Ollama\models` в **системные** переменные → перезапустить Ollama.
**НЕ перемещать модели на C!** Пользователь категорически против.

**Размерные ограничения:** RTX 3050 8GB → максимум ~7 GB модель из-за Vulkan-оверхеда. qwen2.5:14b (9 GB) не влезает (Vulkan alloc fail).

**Why:** Пользователь работает с локальными моделями через Ollama для экономии токенов.
**How to apply:** Если `ollama list` пуст — перезапустить Ollama. Модели >7 GB не ставить.
