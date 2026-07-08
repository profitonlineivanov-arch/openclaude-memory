---
name: Cross-device Session Sync
description: Перенос сессий OpenClaude между смартфоном (Termux) и Windows ноутбуком (2026-07-08, обновлено)
type: project
---

**Цель:** Начать сессию на смартфоне → закрыть → продолжить на Windows → снова на смартфоне. Бесшовный переход.

**Исследование хранилища сессий OpenClaude (2026-07-07):**
- `~/.openclaude/history.jsonl` — 370KB, 1514 строк. Единый файл на ВСЕ сессии. Merge conflict при параллельной записи с двух устройств.
- `~/.openclaude/sessions/<pid>.json` — метаданные активной сессии. Пример: `{"pid":3036,"sessionId":"baac6301-...","cwd":"...","startedAt":1783416678047,"kind":"interactive","status":"busy","updatedAt":1783420794132}`
- `~/.openclaude/projects/<project-hash>/<uuid>.jsonl` — полные логи разговора, по файлу на сессию + подпапка subagents/ с JSONL суб-агентов.
- `~/.openclaude/session-env/<uuid>/` — 73 директории, все пустые, не используются.

**CLI OpenClaude:**
- `--resume <session-id>` — возобновить по UUID
- `--session-id <uuid>` — начать с конкретным ID
- НЕТ `session save/export/import` субкоманды

**3 варианта предложено (2026-07-07):**
1. **Через память git (работает сейчас, самый простой)** — при переключении я сохраняю handoff-заметку в .md, sync.sh пушит. На другом девайсе читаю → продолжаю. Минус: только контекст, не полный диалог.
2. **Через сервер 45.146.164.144 как relay** — скрипт копирует .jsonl сессии на сервер → оттуда на другой девайс. Плюс: полная история. Минус: ручной перенос, конфликты.
3. **Syncthing папки сессий** — держать `.openclaude/sessions/` и `projects/.../` в Syncthing. Минус: платформозависимые пути.

**Ruflo MCP — статус на 2026-07-08:**

Ruflo MCP tools перечислены среди доступных (session_export/import/save/restore). Пользователь подтвердил, что ruflo есть и на Windows.

**Проблема (была):** MCP сервер отсутствовал в текущем `.openclaude.json` — `"mcpServers": {}` пустой. Во ВСЕХ бекапах конфиг есть:

```json
"ruflo": {
  "type": "stdio",
  "command": "ruflo",
  "args": ["mcp", "start"]
}
```

**FIX (2026-07-08):** Ruflo MCP конфиг добавлен в `.openclaude.json` (в корневой `mcpServers` рядом с caveman-shrink). Результат:
- `which ruflo` → `/data/data/com.termux/files/usr/bin/ruflo` ✅
- `ruflo --version` → `ruflo v0.0.0` (не 3.25.1 как было в mcp-servers-catalog)
- `mcp__ruflo__mcp_status` → running, PID 3146, stdio transport ✅
- `mcp__ruflo__session_current` → "No saved sessions" (пустое хранилище)
- `mcp__ruflo__session_list` → sessions: [], total: 0

**Следующий шаг:** Нужно сохранить текущую сессию через `session_save`, затем экспортировать через `session_export` в файл. Этот файл можно класть в git-репозиторий памяти. На Windows — `session_import`.

**Решение пользователя (2026-07-08):**
- GitHub как транспорт (как и раньше)
- **Вариант А (fix ruflo MCP):** выполнен. Конфиг восстановлен, MCP работает.

**Итог тестирования ruflo session tools (2026-07-08):**
- `mcp__ruflo__mcp_status` → running, PID 3146 ✅
- `mcp__ruflo__session_current` → "No saved sessions" (пустое хранилище ruflo)
- `mcp__ruflo__session_list` → sessions: [], total: 0
- `mcp__ruflo__session_save` → **FAIL** — "Tool call aborted during URL elicitation"

**Вывод:** Ruflo session инструменты нестабильны — save/export не работают. План А провалился.

**Новый план (пользователь согласился "ок", 2026-07-08):**
- **Вариант В: hook-based автоматический handoff без ruflo**
- session-end хук: авто-сохраняет контекст в .md память, коммитит, пушит
- session-start хук: пуллит, читает handoff → продолжаем
- Настройка: hooks в settings.json

**Доп. детали:**
- `.openclaude.json` имеет ДВА ключа `mcpServers` (строка 130 пустой для projects/, строка 203 для глобального). Ruflo добавлен в глобальный.
- `settings.json` — ruflo не упоминается. MCP серверы конфигурятся в `.openclaude.json`.

**Схема работы (handoff через .md, fallback):**
1. На телефоне: я пишу handoff-заметку в .md память с текущим контекстом
2. sync.sh пушит в GitHub
3. На винде: git pull, память синхронизируется
4. Я читаю handoff на винде → продолжаю
5. И наоборот

**Why:** Пользователь работает на 2 устройствах (Android Termux + Windows ноутбук) и хочет продолжать диалоги на разных машинах. GitHub уже используется для памяти.
**How to apply:** При запросе на переключение устройства — сохранить handoff-заметку в .md, сказать запустить sync.sh, на другом устройстве память подтянется. Если ruflo MCP заработает — можно экспортировать полную сессию вместо ручного handoff.