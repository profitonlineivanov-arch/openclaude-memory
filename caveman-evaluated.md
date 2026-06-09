---
name: Caveman Installed
description: JuliusBrussee/caveman — output compression plugin УСТАНОВЛЕН, hooks + caveman-shrink MCP, -65% output токенов (2026-06-09)
type: reference
---

**Caveman** — плагин/скилл для AI-агентов, заставляющий отвечать максимально кратко. УСТАНОВЛЕН 2026-06-09.

**Статус:** Активен. Хуки в `~/.claude/hooks/`, caveman-shrink MCP добавлен в `~/.openclaude.json`, статус-бар настроен.

**Что делает:** Инструктирует агента убирать воду из ответов. Влияет только на output токены, reasoning не трогает. Техническая точность сохраняется (код, пути, URL — byte-preserved).

**Режимы:** lite (убрать filler), full (по умолчанию), ultra (телеграфный), wenyan (классический китайский).

**Установка:**
- Хуки: `~/.claude/hooks/caveman-*.js` (6 файлов)
- SessionStart hook: автоматическая активация при старте сессии
- UserPromptSubmit hook: трекинг на каждый промпт
- caveman-shrink MCP: `npx -y caveman-shrink` — сжимает описания MCP-инструментов
- Статус-бар: показывает экономию токенов

**Команды:**
- `/caveman` или "caveman mode" — включить в текущей сессии
- `/caveman-commit` — коммиты ≤50 символов
- `/caveman-review` — однострочные PR-ревью
- `/caveman-stats` — статистика экономии
- `/caveman-compress <file>` — сжимает memory файлы на ~46%

**Удаление:** `npx -y github:JuliusBrussee/caveman -- --uninstall`

**Why:** Пользователь попробовать. Скилл для экономии токенов, комплементарен с CodeGraph.

**How to apply:** В новой сессии включается автоматически. В текущей — `/caveman`. Если стиль ответов мешает — отключить uninstall-командой.
