---
name: Plugins & MCP Servers Catalog
description: 9 плагинов + 3 MCP-сервера: Playwright, Chrome DevTools, Context7, Firecrawl, Security Guidance, Code Review, TypeScript LSP, Frontend Design, Caveman, CodeGraph
type: reference
---

## Установленные плагины (2026-06-06, Caveman 2026-06-09)

Всего 9.

### MCP-серверы (в `.mcp.json`)

**1. Playwright** — управление браузером, автоматизация
**2. Chrome DevTools** — отладка Chrome, DOM, сеть

### MCP-серверы (через плагины / отдельно)

**3. Context7** — документация библиотек
**4. Firecrawl** — веб-скрейпинг (v1.0.8, требует FIRECRAWL_API_KEY)
**5. CodeGraph** — семантический граф кода (в `~/.claude.json`, не в `.mcp.json`)
**6. caveman-shrink** — сжатие описаний MCP-инструментов (в `~/.openclaude.json`)

### Хуки

**7. Security Guidance** — проверка на уязвимости перед применением
**8. Caveman** — output compression (-65% токенов), SessionStart + UserPromptSubmit hooks

### Агенты

**9. Code Review** — мульти-агентное ревью PR
**10. Frontend Design** — улучшение UI

### LSP

**11. TypeScript LSP** — IntelliSense TS/JS (v1.0.0)

## Конфигурация

**CodeGraph** (`~/.claude.json`):
```json
{
  "mcpServers": {
    "codegraph": {
      "type": "stdio",
      "command": "/data/data/com.termux/files/home/.local/bin/codegraph",
      "args": ["serve", "--mcp"]
    }
  }
}
```

**Playwright + Chrome DevTools** (`.mcp.json`):
```json
{
  "mcpServers": {
    "playwright": { "command": "npx", "args": ["@playwright/mcp@latest"] },
    "chrome-devtools": { "command": "npx", "args": ["-y", "chrome-devtools-mcp@latest", "--headless"] }
  }
}
```

**caveman-shrink** (в `~/.openclaude.json`):
```json
"mcpServers": { "caveman-shrink": { "command": "npx", "args": ["-y", "caveman-shrink"] } }
```

## Установка плагинов

`openclaude plugin install <name>@<marketplace>`
