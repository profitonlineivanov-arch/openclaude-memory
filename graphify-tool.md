---
name: Graphify Knowledge Graph Tool
description: safishamsi/graphify (PyPI: graphifyy) — knowledge graph builder, УСТАНОВЛЕН v0.8.33, работает (2026-06-07)
type: reference
---

**Что такое:** Инструмент для построения графа знаний из кодовой базы. Парсит код через tree-sitter (локально, без API), строит граф связей (функции, классы, импорты, комментарии). Выдаёт `graph.html` (визуализация), `GRAPH_REPORT.md`, `graph.json`.

**Ключевые возможности:**
- MCP-сервер для структурированных запросов (`query_graph`, `get_node`, `get_neighbors`, `shortest_path`)
- Auto-rebuild на git commit
- PR dashboard, call-flow диаграммы
- Совместим с Claude Code, Codex, Cursor и другими AI-ассистентами

**Установка:** `pip install graphifyy --user --timeout 300 --retries 10`, затем `graphify install` для регистрации в AI-ассистенте.

**Termux-совместимость (РЕШЕНА 2026-06-07):**
- Блокер 1: scipy → нужен Fortran. `apt install flang` (flang, mlir, libandroid-complex-math, libandroid-complex-math-static; 1241 MB).
- Блокер 2: tree-sitter парсеры → `apt install tree-sitter` даёт `api.h`, создан compat `parser.h`.
- Итог: graphifyy 0.8.33 УСТАНОВЛЕН. 11 tree-sitter парсеров работают (bash, c, c-sharp, fortran, go, javascript, lua, objc, powershell, python, swift). 14 парсеров НЕ собрались (cpp, elixir, groovy, java, json, julia, kotlin, php, ruby, rust, scala, typescript, verilog, zig) — старый API tree-sitter <0.22, нужен реген грамматик мейнтейнерами.
- Команда: `python3 -m graphify` (не `graphify`, т.к. ~/.local/bin не в PATH).

**Статус:** 2026-06-07 — установлен и работает.
