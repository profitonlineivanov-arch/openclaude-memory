---
name: Plugins & MCP Servers Catalog
description: 8 плагинов + 3 MCP-сервера (Playwright, Chrome DevTools, caveman-shrink). Провайдеры ВОССТАНОВЛЕНЫ из configs/. CodeGraph — Termux only.
type: reference
---

## Текущее состояние (2026-06-14)

### Плагины (8)
1. **context7@claude-plugins-official** — документация библиотек
2. **firecrawl@claude-plugins-official** — веб-скрейпинг (v1.0.9)
3. **security-guidance@claude-plugins-official** — проверка уязвимостей (v2.0.6)
4. **code-review@claude-plugins-official** — мульти-агентное ревью PR
5. **typescript-lsp@claude-plugins-official** — IntelliSense TS/JS (v1.0.0)
6. **frontend-design@claude-plugins-official** — улучшение UI
7. **playwright@claude-plugins-official** — управление браузером (установлен 2026-06-14)
8. **caveman@caveman** — output compression (25d22f8)

### MCP-серверы

**`.mcp.json`:** playwright + chrome-devtools (создан 2026-06-14)
**`.openclaude.json`:** caveman-shrink (добавлен 2026-06-14)

### Провайдеры (ВОССТАНОВЛЕНЫ 2026-06-14)
4 провайдера восстановлены из `configs/` memory-репо: Gitlawb Opengateway, DeepSeek, NVIDIA NIM, Bluesminds.

### НЕ на Windows
**CodeGraph** — Termux only (aarch64 binary).
