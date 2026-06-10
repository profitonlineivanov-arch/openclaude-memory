---
name: Pinterest API field_set_key для досок
description: BoardsResource без field_set_key + BoardResource для имён. "partner" и "profile" не работают.
type: feedback
---

Для получения списка досок Pinterest:

- `BoardsResource/get/` БЕЗ `field_set_key` — возвращает список досок с node_id, но **без названий**
- `BoardResource/get/` с `board_id` (число) — возвращает полные данные доски включая name, url. Использовать как второй этап.
- `UserResource/get/` + `field_set_key: "profile"` → **НЕ РАБОТАЕТ** для досок. Возвращает профиль но без boards массива (лог 17:33).
- `BoardsResource/get/` + `field_set_key: "partner"` → только node_id + collaborating_users, без имён
- `BoardsResource/get/` + `field_set_key: "board_report"` → должен давать name, url, privacy (не проверен из-за других багов, 2026-06-10)

**Why:** Без field_set_key BoardsResource даёт список но без названий. Нужен второй запрос BoardResource/get/ по board_id для получения имён. "partner" и "profile" не дают нужных данных.

**How to apply:** 2-этапный подход: BoardsResource (список) → BoardResource (названия). HTML fallback: `/$username/boards/`.