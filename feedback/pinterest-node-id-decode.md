---
name: Pinterest 2-stage board loading
description: BoardsResource для node_id списка + BoardResource/get/ с board_id для имён — 2-этапная загрузка (2026-06-10)
type: feedback
---

Если `BoardsResource/get/` возвращает доски с `node_id` (base64) но без `name`:

1. Декодировать node_id: `Base64.decode(nodeId)` → "Board:778278448044403500"
2. Извлечь числовой ID: "Board:778278448044403500".replace("Board:", "")
3. Вызвать `BoardResource/get/` с `options.board_id = числовой_ID`
4. `source_url=/Soulexpert/board/` (username динамический)
5. Имя из `resource_response.data.name`, fallback — `data.url`
6. URLDecoder.decode(name, "UTF-8").replace("-", " ").trim()

**Why:** `BoardsResource/get/` без field_set_key возвращает node_id без названий. `BoardResource/get/` требует bookmarks если не указан board_id. С board_id возвращает полные данные включая name.

**How to apply:** Двухэтапный подход: сначала BoardsResource для списка ID, затем BoardResource для каждого имени. Логировать каждый этап.