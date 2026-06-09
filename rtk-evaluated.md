---
name: rtk-evaluated
description: rtk-ai/rtk — CLI proxy для сжатия вывода shell-команд, снижает токены на 60-90%. НЕ code intelligence (2026-06-09)
type: reference
---

**RTK (Rust Token Killer)** — CLI proxy, перехватывающий shell-команды AI-агентов и сжимающий их вывод.

**Что делает:** Сидит между AI-агентом и shell. `git status` → `rtk git status` → сжатый вывод. Снижает потребление токенов на 60-90%. 100+ команд поддерживается, overhead <10мс.

**Стратегии сжатия:** smart filtering, grouping, truncation, deduplication. Режим `--ultra-compact`.

**Установка:** `brew install rtk`, curl-скрипт в `~/.local/bin`, `cargo install`, или бинарники с GitHub.

**Команды:** `rtk gain`, `rtk discover`, `rtk session` — аналитика экономии токенов.

**НЕ является:**
- MCP-сервером (CLI hook, не протокол)
- Code intelligence (нет AST, графов, семантики)
- Заменой CodeGraph (совершенно разные задачи)

**Совместимость:** Claude Code, Copilot, Gemini CLI, Codex, Cursor, Windsurf, Cline и др. (14 AI-инструментов). Hook перезаписывает команды прозрачно.

**Покрытие:** JavaScript/TypeScript (Jest, ESLint, Next.js), Python (pytest, ruff), Rust (cargo), Go, Ruby, Docker, K8s, AWS CLI, GitHub CLI, Prisma.

**Влияет только на Bash tool** — не затрагивает встроенные Read/Grep/Glob инструменты OpenClaude.

**Why:** Пользователь asked to evaluate. Оказалось — инструмент для экономии токенов, не для анализа кода. Дополняет CodeGraph, не конкурирует.

**How to apply:** НЕ ставить. Экономия токенов маргинальная для нашего workflow (Read/Grep — основные инструменты, а не Bash). RTK не затрагивает встроенные инструменты, а SSH-вывод с сервера не фильтрует эффективно. Потенциальный источник скрытых багов (обрезанный вывод). Рассматривать только если токены станут критичным bottleneck.
