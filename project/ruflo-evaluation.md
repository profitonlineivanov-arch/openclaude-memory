---
name: Ruflo Evaluation
description: ruvnet/ruflo — agent meta-harness, evaluated for OpenClaude compatibility (2026-07-06)
type: project
---

## Ruflo (ruvnet/ruflo)

**Что это:** Agent meta-harness на TypeScript (63k stars, MIT). Оркестратор поверх AI-агентов (Claude Code / Codex / Hermes). 100+ специализированных агентов, swarm coordination, HNSW векторная память, federation между машинами, AIDefence.

**Совместимость с OpenClaude:**

| Путь | Статус |
|------|--------|
| MCP server | ✅ Работает — `claude mcp add ruflo -- npx ruflo@latest mcp start`. Откроет ~210 MCP-инструментов |
| CLI init (`npx ruflo init`) | ⚠️ Ставит хуки и `.claude/` конфиги для Claude Code. В OpenClaude — нужно тестировать |
| Plugin marketplace | ❌ Не гарантировано — `/plugin install ruflo-core@ruflo` для Claude Code, своя система плагинов |
| Hooks | ⚠️ Ruflo полагается на hooks Claude Code — если OpenClaude не поддерживает hooks, часть автоматизации не работает |

**Ключевые фичи:** Swarm coordination, AgentDB + HNSW, self-learning (SONA), federation (кросс-машинная коммуникация агентов), 35+ плагинов.

**Вердикт:** MCP-серверная часть совместима напрямую. Плагины и хуки — неопределённо. Рекомендуемый старт: MCP server.

**Практические выгоды для пользователя (2026-07-06):**

| Фича | Что даёт | Как ощущается |
|------|----------|---------------|
| AgentDB память | Я помню детали проектов между сессиями сам, без напоминаний | "мы же обсуждали это 2 недели назад" — и находит |
| Swarm координация | Несколько агентов работают параллельно | Один анализирует 2x2, второй фиксит PinFlow, третий чистит сервер |
| Background workers | Автоматические проверки без команды | "каждые 5ч проверять логи PinFlow", "если дашборд упал — перезапустить" |
| Federation | Агент на Windows + агент на сервере — одна команда | Команды на 45.146.164.144 без ручного SSH |
| AIDefence | Защита от prompt injection | Блокирует вредоносный контекст |

**Привязка к проектам пользователя:**
- 2x2: фоновая проверка базы, авто-статистика
- PinFlow: pipeline code → build → scp → APK готов
- Сервер 45.146.164.144: агент на сервере выполняет скрипты, результат сюда
- API лотерей: фоновый polling без ручных команд

**Нюансы:** 732 open issues — проект нестабилен. Часть плагинов под Claude Code, не OpenClaude.

**Why:** User спросил "можно ли использовать для этого агента" — ответ: да, через MCP server. Затем спросил "что даст и как увижу" — ответ: конкретные выгоды для 2x2, PinFlow, сервера.
**How to apply:** При вопросах об интеграции сторонних agent harness-ов — предлагать MCP server как основной путь. При объяснении новых инструментов — привязывать к конкретным проектам пользователя (2x2, PinFlow, сервер).

## Установка (2026-07-06)

**Статус:** Установлен и подключён.

**Шаги:**
1. `npm install -g ruflo@latest` → ruflo@3.25.1
2. `openclaude mcp add ruflo -- node <npm-path>/ruflo.js mcp start` → stdio MCP добавлен
3. `openclaude mcp list` → ruflo ✓ Connected

**Проблемы:** Симлинк `ruflo` не создался в bash (Windows/msys2). Работает через прямой путь к `bin/ruflo.js`.

**Доступные MCP-инструменты (~100+):**
- Agent (10): spawn, exec, terminate, status, list, pool, health, update, logs, managed-агенты
- Swarm (4): init, status, shutdown, health
- Memory (24): key-value store, agenticow (COW-fork vector DB), semantic search, экспорт/импорт
- Hooks (20+): pre/post command, pre/post edit, SONA обучение, routing, session management
- Config (6): get/set/list/reset/export/import

**Далее:** Пользователь согласился перезапустить OpenClaude, чтобы инструменты стали доступны.
