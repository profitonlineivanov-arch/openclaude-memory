---
name: PinFlow — API v5/web endpoints, не cookies
description: Pinterest API v5/v1 требует OAuth bearer. Для cookie-сессий работают только web-эндпоинты /resource/... с CSRF. Root cause большинства багов R2-R4.
type: feedback
---

В PinFlow (Pinterest automator) все запросы делаются с cookies из `SessionManager.getCookies()`. Pinterest **API v5 (`api.pinterest.com/v5/...`) и API v1 (`api.pinterest.com/v1/...`) требуют OAuth bearer token**, а не session cookies — они возвращают 401/403 на cookie-запросы.

**Why:** Несколько раундов багов (Round 2-4) — `loadUserBoards` отдаёт имя аккаунта, `unfollowUser` молча fail, `createPin` 403 — все корнями уходят в обращение к `api.pinterest.com`. Это системная проблема архитектуры автоматора, а не конкретных функций.

**How to apply:**
- Для доски: `BASE_URL/resource/UserResource/getBoardsResource/` (web)
- Для отписки: `BASE_URL/resource/UserFollowResource/delete/` (web) с `Content-Type: application/json` (R6 fix: был `UserResource/delete/` = удаление аккаунта!)
- Для постинга: `BASE_URL/resource/PinResource/create/` (web) с form-urlencoded. Тело: `source_url=/<username>/pin-builder/&data={"options":{"board_id":"...","title":"...","description":"...","image_url":"...","link":"..."},"context":{}}`. Изображение сначала загружается multipart на `/upload-image/`, потом image_url передаётся в data.options.
- Для лайка: `BASE_URL/resource/PinResource/like/` или `PinResource/unlike/`
- **Все web-эндпоинты требуют CSRF:** `csrftoken=...` из cookies → header `X-CSRFToken: <token>`
- Параллельно нужен `X-Requested-With: XMLHttpRequest` и `Content-Type: application/x-www-form-urlencoded`
- CSRF fallback: random 24-char hex если в cookies нет (token обновится при следующем login)
- `__PWS_DATA__` JSON в HTML — основной источник и для image URLs, и для board list, и для username. Парсить рекурсивно с фильтром по `type`.
- Перед запросом всегда проверять `cookies.isNotEmpty()` — иначе 302 на login

Признак что напоролись на API-vs-web: HTTP 401, 403, или пустой JSON `{}` без `resource_response`. Переключать на web-эндпоинт.
