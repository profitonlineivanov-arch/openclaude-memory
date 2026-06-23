---
name: Caveman Installed
description: JuliusBrussee/caveman — output compression plugin УСТАНОВЛЕН, hooks активны, caveman-shrink MCP сломан (2026-06-09, восстановлен 2026-06-14, исправлен 2026-06-23)
type: reference
---

**Caveman** — плагин/скилл для AI-агентов, заставляющий отвечать максимально кратко. УСТАНОВЛЕН 2026-06-09.

**Статус (2026-06-23):** Плагин работает (hooks). `caveman-shrink` MCP — сломан (npm 404), удалён из `.openclaude.json`.

**Что делает:** Убирает воду из ответов. Влияет только на output токены. Техническая точность сохраняется.

**Режимы:** lite, full (по умолчанию), ultra, wenyan.

**Установка:**
- Hooks: `~/.openclaude/plugins/marketplaces/caveman/src/hooks/` (SessionStart + UserPromptSubmit)
- `caveman-shrink` — **сломан**, удалён из MCP проверки

**Команды:**
- `/caveman` или "caveman mode" — включить
- `/caveman lite|full|ultra` — переключить
- `/caveman-commit` — коммиты ≤50 символов
- `/caveman-review` — однострочные PR-ревью
- `/caveman-stats` — статистика экономии