---
name: Graphify Knowledge Graph Tool
description: safishamsi/graphify (PyPI: graphifyy) — knowledge graph builder for codebases, 60K+ stars, incompatible with Termux (scipy needs Fortran compiler)
type: reference
---

**Что такое:** Инструмент для построения графа знаний из кодовой базы. Парсит код через tree-sitter (локально, без API), строит граф связей (функции, классы, импорты, комментарии). Выдаёт `graph.html` (визуализация), `GRAPH_REPORT.md`, `graph.json`.

**Ключевые возможности:**
- MCP-сервер для структурированных запросов (`query_graph`, `get_node`, `get_neighbors`, `shortest_path`)
- Auto-rebuild на git commit
- PR dashboard, call-flow диаграммы
- Совместим с Claude Code, Codex, Cursor и другими AI-ассистентами

**Установка:** `uv tool install graphifyy` или `pipx install graphifyy`, затем `graphify install` для регистрации в AI-ассистенте.

**Проблема на Termux:** НЕ только сеть — главный блокер это **отсутствие Fortran-компилятора** (gfortran/flang/ifort). scipy собирается из исходников (нет wheel'ов под aarch64-linux-android + Python 3.13) и требует flang, иначе `metadata-generation-failed`. Попытки 1-4 (2026-06-06) провалились на таймаутах PyPI. Попытка 5 (2026-06-07) с `--user --timeout 300 --retries 10` прошла сеть, но упала на сборке scipy с `metadata-generation-failed: ERROR Running 'flang --help' gave "No such file or directory"`. `gcc` есть, `gfortran` — нет.

**Пути решения:**
1. **proot-distro Ubuntu** в Termux — там есть готовые scipy wheel'ы (`apt install python3-scipy`)
2. **Установить на сервер 45.146.164.144** (Ubuntu x86_64) — самый надёжный путь, wheel'ы скачиваются мгновенно
3. Попробовать `apt install gfortran` в Termux (может не быть в репо)

**Дата проверки:** 2026-06-07 (5 попыток, последняя провалилась на scipy Fortran)
