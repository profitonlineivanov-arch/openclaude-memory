---
name: PinFlow Round 4 — username extraction + ImageParser fixes applied
description: Username extraction FIXED (3-layer: URL-decode cookies, __PWS_DATA__ JS, HTTP OkHttp). ImageParser nullable chain + escape fixes. Commit b1ec51e, APK pinflow-1030.apk.
type: project
---

**Статус (2026-06-08 18:04):** Round 4 и Round 5 объединены в один коммит `64c5964`. APK `pinflow-1031.apk` собран и лежит в `~/storage/downloads/`. Подробности: [Round 5](project/pinflow-round5-fixes-done-2026-06-08.md). **Не протестировано на устройстве.**

## Причина проблемы
Username всегда был "PinterestUser" (fallback), потому что:
1. Кука `_pinterest_sess` — URL-encoded JSON, не plain JSON
2. `__INITIAL_STATE__.user.me` не существует на современном Pinterest
3. После логина URL = `pinterest.com/` (homepage), а не профиль

## Решение (3 слоя, commit `b1ec51e`)
1. **Cookie extraction** (`extractUsernameFromCookies`): URL-decode `_pinterest_sess`, поиск по 6 JSON полям (canonical_username, username, login_name, full_name, first_name, display_name)
2. **Page JS parsing** (`extractUsernameFromPage`): добавлен `__PWS_DATA__` deep search + множественные пути
3. **HTTP fallback** (`extractUsernameViaHttp`): OkHttp запрос homepage с куками, парсинг `__PWS_DATA__` JSON + рекурсивный `findUsernameInJson()`

## ImageParser.kt fixes (в том же коммите)
- `"\/"` → `"/"` (illegal Kotlin escape)
- `url?.replace().replace()` → `url?.replace()?.replace()` (nullable chain)
- `urls.add(String?)` → `.let { urls.add(it) }` (type mismatch)

## Коммиты
- `47f3324` — 9 файлов, план 8+ исправлений
- `280beec` — улучшенный HTML-парсинг following
- `487714a` — фикс краша RecyclerView
- `b1ec51e` — username extraction (3-layer) + ImageParser fixes

APK: `pinflow-1030.apk` (8.3 MB) в `~/storage/downloads/`. Старый `pinflow_app-debug_20260608_1300.apk` удалён.
