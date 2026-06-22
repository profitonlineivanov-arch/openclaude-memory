---
name: PinFlow Test 2026-06-21 + Fixes Applied
description: APK test 2026-06-21: 4 бага найдены, 3 исправлены (double-start, auto-restore, NetworkOnMainThread). followTime=0 pending.
type: project
---

**Дата теста:** 2026-06-21
**APK:** собран на сервере 45.146.164.144, код изменён на др. устройстве
**Лог:** `/sdcard/Download/pinflow_log_20260621_080009.txt` (63 KB)

## bugs found in log
1. **Double-start** — loadAccount в onCreate + onResume → 2 автоматизации parallel → race CSRF
2. **Auto-restore до login** — стартует при automationRunning флаге без проверки валидности cookies
3. **NetworkOnMainThread** — extractUsernameViaHttp на Main Thread внутри runBlocking(Dispatchers.Main)
4. **followTime=0** — unfollow 0, все юзеры с followTime=0

## fixes applied (2026-06-21)
- **Double-start fix** (MainActivity.kt): убран loadAccount() из onCreate — onResume вызовется сразу после
- **Auto-restore fix** (MainActivity.kt:243): добавлена проверка `_pinterest_sess` cookie перед auto-restore; если куки нет — очистить флаг
- **NetworkOnMainThread fix** (AuthActivity.kt:557): `client.newCall(request).execute()` обёрнут в `withContext(Dispatchers.IO)`; убран бессмысленный `runBlocking(Dispatchers.Main)`
- **followTime username key fix** (PinterestAutomator.kt): `followedUsers` map переключен с `user.id` на `user.username` (v3 diff).

## followTime=0 — fix in progress (2026-06-21 session)
Причина: `followedUsers` SharedPreferences пуст (подписки до разработки). `getFollowingUsers()` → HTML/403, fallback создаёт `UserDataWithFollowerStatus` без времени → все с `followTime=0`.

**Fix applied:**
1. `UserDataWithFollowerStatus` — новое поле `followTime: Long = 0L`
2. HTML fallback парсит `window.__PINTEREST_APP__` / `window.__INITIAL_STATE__` через `extractJsonFromHtml()` (brace matching) и подаёт в `findFollowingInJson`
3. `findFollowingInJson` вытягивает `followed_at` в `followTime`
4. `executeUnfollowTask`: приоритет `user.followTime > 0 ? user.followTime : followedUsers[user.username]`. Если `followTime == 0L` — skip unfollow

**Status:** Код изменён, коммит и пуш на GitHub готовы. Build запущен на сервере 45.146.164.144 (2026-06-22). Сессия прервана до завершения build — результат неизвестен.