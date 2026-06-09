---
name: CodeGraph
description: colbymchenry/codegraph v0.9.9 — semantic code intelligence MCP server, замена Graphify (2026-06-09)
type: reference
---

**Что такое:** Семантический инструмент анализа кода. Парсит через tree-sitter AST → SQLite + FTS5 → MCP-сервер. Заявлено: -58% tool calls, -16% cost, -47% tokens.

**Версия:** v0.9.9 (linux-arm64 bundle), установлен через standalone installer.

**Установка:**
- Путь: `~/.codegraph/versions/v0.9.9/`
- Symlink: `~/.local/bin/codegraph → ~/.codegraph/versions/v0.9.9/bin/codegraph`
- PATH: `~/.local/bin` добавлен в `.bashrc`
- MCP регистрация: `~/.claude.json` (mcpServers.codegraph) + `~/.claude/settings.json` (permissions)

**Termux-фикс:** Shell shim `~/.codegraph/versions/v0.9.9/bin/codegraph` переписан: `exec node --liftoff-only "$DIR/lib/dist/bin/codegraph.js" "$@"` вместо `exec "$DIR/node"` (bundled Node — glibc, не работает в Termux/Bionic). Используется системный Node v24.15.0. Флаг `--liftoff-only` — обход V8 turboshaft WASM OOM (issues #293/#298).

**MCP инструменты (8 штук):**
- `codegraph_explore` — исследование кодовой базы
- `codegraph_search` — поиск по AST
- `codegraph_node` — информация об узле
- `codegraph_callers` — кто вызывает функцию
- `codegraph_callees` — что функция вызывает
- `codegraph_impact` — impact analysis
- `codegraph_files` — файлы проекта
- `codegraph_status` — статус индекса

**Проиндексированные проекты:**
- `~/pinflow/` — 58 файлов, 744 узла, 1522 рёбра (Kotlin/Gradle)
- 2x2, 1224, 4x20 — только на сервере, локально нечего индексировать

**Команды:**
- `codegraph init <dir>` — индексация проекта
- `codegraph serve --mcp` — запуск MCP-сервера
- `codegraph install -t claude -y --location global` — регистрация в Claude/OpenClaude

**Why:** Graphify не работал (11/25 парсеров, не интегрирован, Kotlin не поддерживался). CodeGraph — нативная MCP интеграция, 20+ языков, авто-sync.

**How to apply:** Индексация по одному проекту (`codegraph init <dir>`). Глобального индекса нет. Локально только PinFlow. MCP-инструменты доступны после перезапуска сессии OpenClaude.
