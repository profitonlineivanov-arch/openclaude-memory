---
name: Plugins & MCP Servers Catalog
description: 8 плагинов + 3 MCP (Playwright, Chrome DevTools, codegraph). CodeGraph — Termux only. caveman-shrink удалён 2026-06-23.
type: reference
---

## Текущее состояние (2026-07-08)

### Плагины (8)
1. **context7@claude-plugins-official** — документация библиотек
2. **firecrawl@claude-plugins-official** — веб-скрейпинг (v1.0.9)
3. **security-guidance@claude-plugins-official** — проверка уязвимостей (v2.0.6)
4. **code-review@claude-plugins-official** — мульти-агентное ревью PR
5. **typescript-lsp@claude-plugins-official** — IntelliSense TS/JS (v1.0.0)
6. **frontend-design@claude-plugins-official** — улучшение UI
7. **playwright@claude-plugins-official** — управление браузером
8. **caveman@caveman** — output compression

### MCP-серверы (2026-07-08)

| Сервер | Конфиг | Статус |
|--------|--------|--------|
| chrome-devtools-mcp | `.mcp.json` | ✅ 1.4.0 |
| playwright-mcp | `.mcp.json` | ⚠️ не проверен (нет chromium в Termux) |
| caveman-shrink | `.openclaude.json` | ❌ УДАЛЁН 2026-06-23 (npm 404) |
| codegraph | глобал npm | ✅ 0.9.9 |
| ruflo | `.openclaude.json` | ✅ добавлен 2026-07-08, MCP стартует (из бекапов) |

**caveman-shrink** — настроен в `.openclaude.json` но `npx -y caveman-shrink` не работает. Caveman плагин работает через hooks, MCP не нужен.

**ruflo:**
- Бинарник: `/data/data/com.termux/files/usr/bin/ruflo` — ✅
- Версия: `ruflo v0.0.0` (на сервере могла быть 3.25.1)
- MCP статус: running, PID 3146, stdio transport
- Инструменты: ~100+ (session_export/import, agent_spawn, workflow_execute и др.)
- session_save: ⚠️ FAIL — "Tool call aborted during URL elicitation" (неизвестный URL)

  **Вывод:** session_export/import/save инструменты есть, но session_save падает с ошибкой. Только для чтения/списка. Полноценная syn-хронизация через ruflo не работает.
- Конфиг добавлен в `.openclaude.json` (корневой `mcpServers`), изначально отсутствовал после сброса конфига, восстановлен из бекапов
- Есть и на Windows (подтверждено пользователем)

**CodeGraph** — Termux only (aarch64 binary). Индексирует только PinFlow локально. Остальное — на сервере.

### Провайдеры (ВОССТАНОВЛЕНЫ 2026-06-14)
4 провайдера: Gitlawb Opengateway, DeepSeek, NVIDIA NIM, Bluesminds.

### НЕ на Windows
**CodeGraph** — Termux only.