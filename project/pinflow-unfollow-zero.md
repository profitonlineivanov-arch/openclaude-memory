---
name: PinFlow Unfollow Fix v2
description: Unfollow parser fix v2 — isUserObj widened to json.has("username"), APK built and delivered 2026-06-17
type: project
---

Unfollow не находит пользователей при 403KB JSON от FollowingResource.

**Root cause 2026-06-17:** `findFollowingInJson()` фильтр `isUserObj` слишком строгий — требует `hasFollowState || id.isNotEmpty()`. Pinterest изменил структуру JSON, объекты пользователей не имеют follow-state полей.

**Fix applied (v2):** `isUserObj = type == "user" || id.startsWith("/User/") || json.has("username")` (строка 936 PinterestAutomator.kt).

**Build:** BUILD SUCCESSFUL 2026-06-17, rebuilt 2026-06-18 06:29. APK: `/sdcard/Download/pinflow-unfollow-fix-v2.apk` (8.7 MB).

**Root cause 2026-06-18 07:53:** FollowingResource возвращает HTML page (398KB) вместо JSON. Заголовок `Content-Type: text/html` вместо `application/json`. Pinterest изменил endpoint или требует другие заголовки.

**Fix v4 (2026-06-18 07:57):** Добавлены заголовки:
- `Accept: application/json`
- `Content-Type: application/x-www-form-urlencoded`

APK: `/sdcard/Download/pinflow-unfollow-v4.apk` (8.8 MB).

**Root cause 2026-06-18 07:59:** `following_debug.json` содержит HTML, а не JSON. FollowingResource возвращает HTML страницу (398KB) с `response.code == 200`. Парсер пытается парсить HTML как JSON и находит 0 пользователей.

**Fix в работе:** Проверка `body.startsWith("<!DOCTYPE")` для детекта HTML и fallback на HTML парсинг.

**Status:** Unfixed. JSON endpoint возвращает HTML. Pinterest требует другие заголовки или сменил endpoint.

**Why:** API сломался — HTML вместо JSON, код не детектирует это.
**How to apply:** Детектить HTML по первым символам, использовать HTML fallback с парсингом [data-test-id] элементов.