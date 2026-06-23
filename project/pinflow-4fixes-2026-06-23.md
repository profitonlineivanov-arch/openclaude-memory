---
name: PinFlow 4 Fixes 2026-06-23
description: 4 бага исправлены в pinflow-fixes.apk: WebView thread, getCookies stale fallback, followTime=0 из HTML, username stale при auto-restore
type: project
---

**Дата:** 2026-06-23
**APK:** pinflow-fixes.apk (8.4MB, /sdcard/Download/)

## Что исправлено
1. **WebView on IO thread** — `webView.settings.userAgentString` обёрнут в `withContext(Dispatchers.Main)` (AuthActivity.kt)
2. **CSRF NOT FOUND** — `getCookies()` теперь ONLY `CookieManager.getCookie()`, без fallback на `account.cookies` (PinterestAutomator.kt)
3. **followTime=0** — добавлена `collectFollowTimes()` рекурсивная функция JSON, парсит `followed_at`/`follow_time` из embedded HTML, передаёт в `UserDataWithFollowerStatus`
4. **Username stale** — `start()` теперь читает `SessionManager(context).getUserName()` и обновляет `account` перед запуском

## Файлы изменены
- AuthActivity.kt: `extractUsernameViaHttp` — user agent на Main thread
- PinterestAutomator.kt: `getCookies()`, `start()`, `collectFollowTimes()` + `JSONArray` import

## Тест нужен
- Логин → автоматизация 2+ циклов → проверить CSRF сохраняется
- followTime > 0 в логах для following users
- Username в логе = username из логина, не старый
