---
name: PinFlow 4 Fixes 2026-06-23 + Test Results 2026-06-25
description: 4 бага патчены 2026-06-23, тест 2026-06-25 показал 2/4 persist (CSRF + followTime=0)
type: project
---

**Дата фикса:** 2026-06-23
**APK:** pinflow-fixes.apk (8.4MB, /sdcard/Download/)
**Тест:** 2026-06-25, лог pinflow_log_20260625_080905.txt

## Что исправлено (патч от 23 июня)
1. **WebView on IO thread** — `webView.settings.userAgentString` обёрнут в `withContext(Dispatchers.Main)` (AuthActivity.kt)
2. **CSRF NOT FOUND** — `getCookies()` теперь ONLY `CookieManager.getCookie()`, без fallback на `account.cookies` (PinterestAutomator.kt)
3. **followTime=0** — добавлена `collectFollowTimes()` рекурсивная функция JSON, парсит `followed_at`/`follow_time` из embedded HTML, передаёт в `UserDataWithFollowerStatus`
4. **Username stale** — `start()` теперь читает `SessionManager(context).getUserName()` и обновляет `account` перед запуском

## Результат теста 2026-06-25

| Баг | Статус | Детали |
|-----|--------|--------|
| 1. NetworkOnMainThread | ✅ FIXED | Нет crash в логе |
| 2. CSRF NOT FOUND | ❌ PERSISTS | breathefree0177: 2-й запуск CSRF не найден |
| 3. followTime=0 | ❌ PERSISTS | 12/11 юзеров followTime=0, все skip |
| 4. Username stale | ✅ FIXED | После relogin автоматор использует breathefree0177 |

**Детали CSRF:** После relogin CSRF найден (32 chars), FollowingResource GET → 403 (24 bytes). HTML fallback находит 11-12 usernames из embedded JSON, но без followTime.

**Детали followTime:** `collectFollowTimes()` не находит `followed_at` в HTML. Все подписки сделаны ДО приложения, `followedUsers` SharedPreferences пуст.

**Решение от 2026-06-25:** Follow/unfollow отложены на следующий этап. Код unfollow и связанные баги (CSRF, followTime=0) сохранены в отдельной ветке GitHub. Из текущей версии unfollow удалён.

**FollowingResource статус:** Ранее возвращал JSON intermittently (сессия 2026-06-12: 200 OK 408KB). Сейчас 100% 403 — Pinterest полностью заблокировал API endpoint.
