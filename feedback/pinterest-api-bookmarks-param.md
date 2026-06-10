---
name: Pinterest API correct board endpoint
description: ВСЕ API-подходы провалены (BoardsResource, BoardResource, UserResource). Нужен HTML-парсинг /boards/ страницы.
type: feedback
---

Три Pinterest resource endpoint для работы с досками — **ВСЕ НЕ РАБОТАЮТ** для получения списка досок с названиями:

- `BoardsResource/get/` (plural) — возвращает node_id (base64), но НЕ имена. Без field_set_key тоже без имён.
- `BoardResource/get/` (singular) — возвращает name/url по board_id, но двухэтапный подход (BoardsResource → BoardResource для каждой) **тоже провален** (2026-06-10, пользователь: "доски нн найдены").
- `UserResource/get/` — профиль пользователя. **НЕ содержит доски** (лог 17:33 подтвердил).

**Текущий вывод (2026-06-10):** Pinterest Resource API не предоставляет endpoint для получения списка досок пользователя с названиями. Нужно парсить HTML страницы `/$username/boards/` через DOM-селекторы или найти GraphQL endpoint.

**Why:** 7 итераций разных API-подходов — все провалены. API просто не отдаёт список досок с названиями в сессионном (cookie-based) режиме.

**How to apply:** Парсить HTML `/$username/boards/`. Искать доски через DOM-селекторы (не __PWS_DATA__ и не regex). Альтернативно — GraphQL endpoint если найдётся.