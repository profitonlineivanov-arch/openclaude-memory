---
name: Plugins & MCP Servers Catalog
description: 8 плагинов/MCP-серверов установлено: Playwright, Chrome DevTools, Context7, Firecrawl, Security Guidance, Code Review, TypeScript LSP, Frontend Design
type: reference
---

## Установленные плагины (2026-06-06)

Всего 8. Установка через `openclaude plugin install <name>@claude-plugins-official`.

### MCP-серверы (в `.mcp.json`)

**1. Playwright** — управление браузером, автоматизация, скриншоты
- Пакет: `@playwright/mcp@latest`
- Статус: ✔ активен

**2. Chrome DevTools** — отладка Chrome, анализ сети, DOM
- Пакет: `chrome-devtools-mcp@latest`
- Флаги: `--headless`
- Статус: ✔ активен

### MCP-серверы (через плагины)

**3. Context7** — живая документация библиотек (версионная, в контексте)
- Установлен: `context7@claude-plugins-official`
- Статус: ✔ активен

**4. Firecrawl** — веб-скрейпинг и краулинг
- Установлен: `firecrawl@claude-plugins-official` (v1.0.8)
- Требует `FIRECRAWL_API_KEY` для cloud
- Статус: ✔ активен

### Хуки

**5. Security Guidance** — проверка изменений на уязвимости (XSS, инъекции) перед применением
- Установлен: `security-guidance@claude-plugins-official`
- Статус: ✔ активен

### Агенты

**6. Code Review** — мульти-агентное ревью PR с confidence-based scoring
- Установлен: `code-review@claude-plugins-official`
- Статус: ✔ активен

**7. Frontend Design** — улучшение UI, генерация production-grade интерфейсов
- Установлен: `frontend-design@claude-plugins-official`
- Статус: ✔ активен

### LSP

**8. TypeScript LSP** — IntelliSense для TypeScript/JavaScript
- Установлен: `typescript-lsp@claude-plugins-official` (v1.0.0)
- Статус: ✔ активен

## Не установлены (из рассмотренных)

- **Perplexity MCP** — нет API-ключа
- **Glif MCP** — репозиторий заархивирован
- **Ralph Loop** — избыточен (уже есть /loop + Agent tool)
- **Figma** — только если проект использует Figma
- **Linear** — только если используется Linear для задач
- **Android-specific MCP** — не существует на рынке. Для Android-разработки (PinFlow) достаточно Context7 (доки Android SDK, Kotlin, OkHttp) + Chrome DevTools (отладка WebView). kotlin-language-server возможен, но сложен в Termux.

## Конфигурация `.mcp.json`

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

## Установка плагинов

Команда CLI: `openclaude plugin install <name>@<marketplace>`
Список: `openclaude plugin list`

Можно устанавливать несколько параллельно (независимые процессы).
