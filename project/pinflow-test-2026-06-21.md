---
name: PinFlow Test 2026-06-21 + Fixes Applied
description: APK test 2026-06-21: 4 бага найдены, 3 исправлены. 2026-06-22 log shows 3 bugs persist (NetworkOnMainThread, CSRF, followTime=0).
type: project
---

**Дата теста:** 2026-06-21
**APK:** собран на сервере 45.146.164.144, код изменён на др. устройстве
**Лог:** `/sdcard/Download/pinflow_log_20260621_080009.txt` (63 KB)

## bugs found in 2026-06-21 log
1. **Double-start** — loadAccount в onCreate + onResume → 2 автоматизации parallel → race CSRF
2. **Auto-restore до login** — стартует при automationRunning флаге без проверки валидности cookies
3. **NetworkOnMainThread** — extractUsernameViaHttp на Main Thread внутри runBlocking(Dispatchers.Main)
4. **followTime=0** — unfollow 0, все юзеры с followTime=0

## fixes applied (2026-06-21)
- **Double-start fix** (MainActivity.kt): убран loadAccount() из onCreate — onResume вызовется сразу после
- **Auto-restore fix** (MainActivity.kt:243): добавлена проверка `_pinterest_sess` cookie перед auto-restore
- **NetworkOnMainThread fix** (AuthActivity.kt:557): `client.newCall(request).execute()` обёрнут в `withContext(Dispatchers.IO)`
- **followTime username key fix** (PinterestAutomator.kt): `followedUsers` map switched to `user.username`

## 2026-06-22 followTime fix + re-test
- followTime fix deployed: HTML __INITIAL_STATE__ parsing, UserDataWithFollowerStatus.followTime field
- APK built on server, tested by user
- **Log:** pinflow_log_20260622_071854.txt

## 3 bugs persist in 2026-06-22 log
1. **NetworkOnMainThreadException** — `webView.settings.userAgentString` still called on IO thread (fix was incomplete — only wrapped the HTTP call, not the WebView access before it)
2. **CSRF NOT FOUND on 2nd run** — cookies lose csrftoken after first automation cycle, FollowingResource returns 403
3. **followTime=0 for all 12 users** — HTML parsing doesn't yield `followed_at`, `followedUsers` empty for manual follows, all skipped
4. **Username mismatch** — logged in as `breathefree0177`, automator used `Soulexpert` (account.username stale after re-login)

**Status:** awaiting fixes for the 3 persistent bugs + username sync issue.
