---
name: OpenCode Zen Provider
description: Новый провайдер OpenCode Zen, добавлен 2026-07-03. Модели gpt-5.4, deepseek-v4-flash, deepseek-v4-flash-free, mimo-v2.5-free.
type: project
---

**OpenCode Zen — новый провайдер (2026-07-03)**

- Добавлен в .openclaude.json 2026-07-03 через `/provider`
- Модели, которые были активны: gpt-5.4, deepseek-v4-flash, deepseek-v4-flash-free, mimo-v2.5-free
- Финальная рабочая конфигурация: OpenCode Zen + deepseek-v4-flash-free (установлена дефолтной)
- **Default model:** deepseek-v4-flash-free (установлено пользователем 2026-07-03)

**История переключений (2026-07-03):**
1. Ollama → gemma4:e2b (с метаданными, баг UI подтверждён)
2. Fireworks AI → accounts/fireworks/models/llama-v3p1-70b-instruct → deepseek-v4-flash
3. OpenCode Zen → gpt-5.4 → deepseek-v4-flash → deepseek-v4-flash-free

**Why:** Пользователь активно тестировал/настраивал различные провайдеры. OpenCode Zen — новый провайдер, ранее не задокументированный.
**How to apply:** OpenCode Zen доступен как провайдер через `/provider`. Модели: gpt-5.4, deepseek-v4-flash, deepseek-v4-flash-free, mimo-v2.5-free.
