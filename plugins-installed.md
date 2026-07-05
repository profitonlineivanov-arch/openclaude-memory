---
name: Claude Code Plugins Installed
description: 8 плагинов: context7, firecrawl (v1.0.9), security-guidance, code-review, typescript-lsp, frontend-design, playwright, caveman + 3 MCP-сервера. Провайдеры восстановлены.
type: reference
---

**Установленные плагины (2026-06-14):**

| Плагин | Версия | Источник |
|--------|--------|----------|
| context7 | - | claude-plugins-official |
| firecrawl | 1.0.9 | claude-plugins-official |
| security-guidance | 2.0.6 | claude-plugins-official |
| code-review | - | claude-plugins-official |
| typescript-lsp | 1.0.0 | claude-plugins-official |
| frontend-design | - | claude-plugins-official |
| playwright | - | claude-plugins-official |
| caveman | 25d22f8 | caveman |

**MCP-серверы:**
- `.mcp.json`: playwright + chrome-devtools ✅ (chrome-devtools 1.4.0, playwright-mcp check failed)
- `.openclaude.json`: caveman-shrink ❌ (spawn ENOENT — сломан)
- CodeGraph ✅ 0.9.9 — Termux only, работает

**Провайдеры:** 4 (Gitlawb Opengateway, DeepSeek, NVIDIA NIM, Bluesminds) — восстановлены из configs/ memory-репо 2026-06-14.

**Конфиги:**
- `.openclaude.json` — провайдеры + caveman-shrink MCP
- `settings.json` — enabledPlugins (8) + model (mimo-v2.5-pro) + env + хуки
- `.mcp.json` — Playwright + Chrome DevTools
- `installed_plugins.json` — версии и пути плагинов
