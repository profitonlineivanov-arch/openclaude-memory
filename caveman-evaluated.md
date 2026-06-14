---
name: Caveman Installed
description: JuliusBrussee/caveman — output compression plugin УСТАНОВЛЕН, hooks + caveman-shrink MCP в .openclaude.json, -65% output токенов (2026-06-09, восстановлен 2026-06-14)
type: reference
---

**Caveman** — плагин/скилл для AI-агентов, заставляющий отвечать максимально кратко. УСТАНОВЛЕН 2026-06-09, восстановлен 2026-06-14 после потери конфига.

**Статус:** Активен (full mode). caveman-shrink MCP пересоздан в `~/.openclaude.json` после потери.

**Что делает:** Инструктирует агента убирать воду из ответов. Влияет только на output токены, reasoning не трогает. Техническая точность сохраняется (код, пути, URL — byte-preserved).

**Режимы:** lite (убрать filler), full (по умолчанию), ultra (телеграфный), wenyan (классический китайский).

**Установка:**
- Хуки: `~/.openclaude/plugins/marketplaces/caveman/src/hooks/` (SessionStart + UserPromptSubmit)
- caveman-shrink MCP: `npx -y caveman-shrink` — в `~/.openclaude.json` (ключ `mcpServers.caveman-shrink`)
- Статус-бар: powershell скрипт (pending настройка)

**Команды:**
- `/caveman` или "caveman mode" — включить в текущей сессии
- `/caveman lite|full|ultra` — переключить интенсивность
- `/caveman-commit` — коммиты ≤50 символов
- `/caveman-review` — однострочные PR-ревью
- `/caveman-stats` — статистика экономии
- `/caveman-compress <file>` — сжимает memory файлы на ~46%

**Удаление:** `npx -y github:JuliusBrussee/caveman -- --uninstall`

**Why:** Пользователь попробовать. Скилл для экономии токенов.

**How to apply:** В новой сессии включается автоматически (SessionStart hook). В текущей — `/caveman`. Если стиль ответов мешает — отключить.
