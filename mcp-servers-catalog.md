---
name: MCP Servers Catalog
description: 5 MCP-серверов для OpenClaude: Perplexity, Playwright, Firecrawl, Glif, Chrome DevTools — команды, env-переменные, API-ключи
type: reference
---

Рассмотренные MCP-серверы (2026-06-06):

**1. Perplexity MCP** — живой поиск через Perplexity API
- Пакет: `@perplexity-ai/mcp-server`
- Команда: `npx -y @perplexity-ai/mcp-server`
- Env: `PERPLEXITY_API_KEY` (обязательно)
- Документация: https://docs.perplexity.ai/docs/getting-started/integrations/mcp-server
- **Статус:** не добавлен — нет API-ключа

**2. Playwright MCP** — управление браузером, автоматизация, UI-тесты
- Пакет: `@playwright/mcp@latest`
- Команда: `npx @playwright/mcp@latest`
- Env: не требуется (есть опциональные `PLAYWRIGHT_MCP_*`)
- GitHub: https://github.com/microsoft/playwright-mcp
- Ключевые флаги: `--browser`, `--headless`, `--isolated`, `--extension`, `--caps`
- **Статус:** добавлен в `.mcp.json` (и уже был в плагинах)

**3. Firecrawl MCP** — веб-скрейпинг и краулинг целых сайтов
- Пакет: `firecrawl-mcp`
- Команда: `npx -y firecrawl-mcp`
- Env: `FIRECRAWL_API_KEY` (обязательно для cloud)
- GitHub: https://github.com/firecrawl/firecrawl-mcp-server
- **Статус:** не добавлен — нет API-ключа

**4. Glif MCP** — AI-воркфлоу (изображения, видео) через glif.app
- Пакет: `@glifxyz/glif-mcp-server@latest`
- Команда: `npx -y @glifxyz/glif-mcp-server@latest`
- Env: `GLIF_API_TOKEN` (обязательно)
- GitHub: https://github.com/glifxyz/glif-mcp-server
- **Статус:** пропущен — репозиторий заархивирован (read-only с 26 мая 2026)

**5. Chrome DevTools MCP** — отладка Chrome, анализ сети, инспектирование DOM
- Пакет: `chrome-devtools-mcp@latest`
- Команда: `npx -y chrome-devtools-mcp@latest`
- Env: не требуется
- Ключевые флаги: `--headless`, `--slim`, `--browser-url`, `--isolated`, `--channel`
- GitHub: https://github.com/ChromeDevTools/chrome-devtools-mcp
- **Статус:** добавлен в `.mcp.json` (headless режим)

## Конфигурация `.mcp.json`

Файл создан: `/data/data/com.termux/files/home/.mcp.json`

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    },
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest", "--headless"]
    }
  }
}
```

## Окружение Termux
- Node.js v24.15.0, npx 11.15.0 — доступны
- `.mcp.json` создан в `/data/data/com.termux/files/home/`
- **Ограничение:** Playwright и Chrome DevTools требуют браузер (Chromium). В Termux на Android запуск Chromium может не работать. При следующем запуске OpenClaude MCP-серверы попытаются стартовать — возможны ошибки.
- Формат `.mcp.json` для OpenClaude: `{"mcpServers": {"name": {"command": "...", "args": [...], "env": {...}}}}}
