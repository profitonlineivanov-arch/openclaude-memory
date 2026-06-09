---
name: codegraph-analysis
description: CodeGraph (colbymchenry/codegraph) v0.9.9 — installed, Termux-patched, MCP registered, pinflow indexed (2026-06-09)
type: project
---

CodeGraph — семантический граф знаний кодовой базы (tree-sitter → SQLite + FTS5 → MCP Server). УСТАНОВЛЕН и работает.

**Статус:** Установлен 2026-06-09. Graphify удалён. Termux-фикс применён (shell shim → system node). MCP зарегистрирован в `~/.claude.json`. Pinflow проиндексирован (58 файлов, 744 узла, 1522 рёбра). Требуется перезапуск сессии для загрузки MCP инструментов.

**Архитектура:** tree-sitter парсит AST, извлекает символы и рёбра (calls, imports, extends, implements), хранит в SQLite с FTS5 полнотекстовым поиском. Auto-sync через inotify/FSEvents вотчер с дебаунсом 2с.

**MCP Tools:** codegraph_explore (главный — ответ на "как работает X" за 1 вызов), codegraph_search, codegraph_callers, codegraph_callees, codegraph_impact, codegraph_node, codegraph_files, codegraph_status.

**Бенчмарки (Opus 4.8, 7 репо):** -16% стоимость, -47% токенов, -58% tool calls, -22% время. Лучшие результаты на VS Code (-81% tool calls) и Alamofire (-40% стоимость).

**Языки:** 20+ (Python, Kotlin, Go, Java, C, Swift, Rust, TypeScript, Dart и др.). Framework-aware routes для Django, FastAPI, Flask, Express, NestJS, Laravel, Rails, Spring, Gin и др.

**Установка:** `npm i -g @colbymchenry/codegraph` или `curl -fsSL .../install.sh | sh`. Self-contained Node runtime бандлится — не требует внешнего Node.js. Поддержка Linux arm64.

**100% локально:** SQLite, без API-ключей, данные не покидают машину.

**Why:** Решает проблему "lost in large project" — агент тратит слишком много ходов на Grep/Read циклы для понимания архитектуры. PinFlow (Kotlin, 744 узла) — единственный локальный проект, где CodeGraph реально полезен. Python-проекты на сервере маленькие, Grep/Read достаточны.

**Локальные файлы = исходники до сборки.** PinFlow локально (`~/pinflow/`) — это Android-проект с .kt/.java/.xml файлами для `gradlew assembleDebug`. CodeGraph индексирует эти исходники. APK — скомпилированный артефакт, CodeGraph его не трогает. Основной код всех проектов (PinFlow, 2x2, 1224, 4x20) живёт на сервере/GitHub, на телефоне только копия для сборки.

**How to apply:**
- Graphify удалён (2026-06-09), CodeGraph — замена.
- Индексация по одному проекту: `codegraph init <dir>`. Глобального индекса нет.
- Локально только PinFlow исходники (~/pinflow/). Python-проекты (2x2, 1224, 4x20) на сервере — CodeGraph их не видит.
- MCP-инструменты доступны автоматически после перезапуска сессии OpenClaude.
- При `git pull` или `scp` новых файлов CodeGraph auto-sync подхватит изменения (дебаунс 2с).
