---
name: PinPilot auto-unfollow infinite cycle fixed
description: getFollowing парсил рекомендации вместо подписок; фикса через UserFollowingResource/get/ + break в unfollow + companion guard против параллельных instance (2026-07-14)
type: project
---

Auto-unfollow зацикливался: `unfollowUser` отчитывал success, но список не уменьшался. 3 бага, все исправлены 2026-07-14, подтверждено тестом (854→794 за цикл, ~9× быстрее).

**Корневая причина (баг 1):** НЕ `unfollowUser` — он работал (`UserFollowResource/delete/` → HTTP 200 + node_id). Баг в `getFollowing()` (`PinterestAutomator.kt`): грузил HTML `_following/` → парсил `__PWS_INITIAL_PROPS__`/`__PWS_DATA__` слепым `extractUsersFromJson`. HTML содержит **рекомендации** ("People you may know"), не подписки — все 51 user имели `explicitly_followed_by_me: false`. App отписывал неподписанных → Pinterest echo no-op → повторный getFollowing = те же 51 → бесконечный цикл.

**Рабочий endpoint (проверен live, curl + cookies из app DB):**
- URL: `https://ru.pinterest.com/resource/UserFollowingResource/get/` POST form-urlencoded (project BASE_URL=`https://www.pinterest.com` — эквивалент)
- Body: `source_url=%2F<username>%2F_following%2F&data=<URL-encoded {"options":{"username":"<u>","page_size":50,"bookmarks":[<prev>]},"context":{}}>`
- Headers: X-CSRFToken, X-APP-VERSION `c9867df` (был `888ba5b`), X-Requested-With: XMLHttpRequest, Accept: application/json
- Response: `resource_response.data[]` (id, username, `explicitly_followed_by_me:true`), `resource_response.bookmark` (**singular**, НЕ bookmarks) для пагинации, конец = `-end-`
- **Критично:** работает с опцией `username`, НЕ `user_id` (с user_id → 404 "Пользователь не найден")

**Баг 2:** `unfollowUser` loop бежал все 9 стратегий даже после успеха strategy 1. Фикс: `if(ok){ anyOk=true; break }`. Strategy 1 (POST_FORM UserFollowResource/delete/) рабочая — остальные 8 лишние.

**Баг 3:** `AutomationForegroundService` + `PinterestWorker` оба создавали `PinterestAutomator` + звали `start()` → 2 параллельных instance → 2 unfollow loop (корутины 13527+13699). `isRunning` guard работает только per-instance. Фикс (вариант b, выбрал user): companion `@Volatile var anyInstanceRunning` — guard в `start()`/`restart()`, сброс в `stop()`/`restart()`/`runAutomation` session-expired path. Минимально, не ломает multi-account, без architecture refactor.

**How to apply:**
- Правки в `D:\Projects\apps\PinFlow\app\src\main\java\com\pinflow\automator\PinterestAutomator.kt`
- `followingFallback()` удалён (был источник бага 1)
- 11 других `888ba5b` в pin-create коде НЕ тронуты (вне scope)
- X-APP-VERSION ротируется Pinterest — если `UserFollowingResource` начнёт фейлиться, обновить через свежий `__PWS_DATA__` HTML
- Тест-критерий: `getFollowing: total=N` = реальное число (сотни), цикл завершается, один PID/корутина
- APK: `app\build\outputs\apk\debug\app-debug.apk`, установлен на телефон `1104664412000369`
- Код НЕ закоммичен — первый агент сделает commit/push в profitonlineivanov-arch/pinflow
