---
name: Graphify Knowledge Graph Tool
description: safishamsi/graphify (PyPI: graphifyy) — knowledge graph builder for codebases, 60K+ stars, incompatible with Termux
type: reference
---

**Что такое:** Инструмент для построения графа знаний из кодовой базы. Парсит код через tree-sitter (локально, без API), строит граф связей (функции, классы, импорты, комментарии). Выдаёт `graph.html` (визуализация), `GRAPH_REPORT.md`, `graph.json`.

**Ключевые возможности:**
- MCP-сервер для структурированных запросов (`query_graph`, `get_node`, `get_neighbors`, `shortest_path`)
- Auto-rebuild на git commit
- PR dashboard, call-flow диаграммы
- Совместим с Claude Code, Codex, Cursor и другими AI-ассистентами

**Установка:** `uv tool install graphifyy` или `pipx install graphifyy`, затем `graphify install` для регистрации в AI-ассистенте.

**Проблема на Termux:** Несовместим с Android/ARM64 — ключевые зависимости (`tree-sitter`, `rapidfuzz`) не имеют pre-built wheels для этой платформы, а компиляция C-расширений в Termux крайне медленная и ненадёжная.

**Альтернатива:** Может быть установлен на сервер 45.146.164.144 (Ubuntu x86_64) — установка будет быстрой из-за доступных wheel'ов.

**Дата проверки:** 2026-06-06
