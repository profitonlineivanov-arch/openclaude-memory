---
<<<<<<< HEAD
name: PinFlow Unfollow Bug
description: 2026-06-23 code-level root causes found for auto-unfollow failure; fix in progress
type: project
---

## Status: FIX IN PROGRESS (2026-06-23)

Patch attempt started but blocked by SSH multiline replace failures. Bug NOT yet fixed in code.

## Root causes identified in PinterestAutomator.kt

### Bug 1: Wrong user identity in `findFollowingInJson` (line 1066-1089)
- `id` field from JSON is `/User/12345` resource-style path, not numeric `user_id`
- Pinterest `user_id` is a separate field in the JSON — code doesn't read `user_id` or `user_id_str`
- Fix: add `val rawUserId = json.optString(“user_id”, json.optString(“user_id_str”, id))` and use it as primary id

### Bug 2: Kotlin char literal in `unfollowUser` (line 1125)
- `userId.removePrefix(“/User/”).trim(/)` — `trim(/)` is INVALID Kotlin (bare char literal)
- Should be `trim('/')` with single-quote char
- This likely causes compile error or runtime crash

### Bug 3: `isFollower` semantic confusion (line 1086)
- `isFollower = json.optBoolean(“follows_me”, false) || json.optBoolean(“is_follower”, false)` means “they follow us”
- For following-list users, this is almost always false — but the unfollow loop at line 474 doesn't gate on it, so this is informational not blocker

## Patch approach
- Add `rawUserId` extraction in `findFollowingInJson`
- Fix `trim(/)` → `trim('/')` in `unfollowUser`
- **Blocked**: Python heredoc multiline `replace()` via SSH fails on whitespace matching — need `sed` or line-by-line approach

**Why:** Fresh investigation on 2026-06-23 found concrete code-level bugs, not architectural issues. Earlier theory (“FollowingResource fundamentally unusable”) is superseded.

**How to apply:** Fix the two concrete code bugs (rawUserId + trim literal). Don't rewrite the unfollow endpoint path. After patching, rebuild APK on server.
=======
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
>>>>>>> origin/main
