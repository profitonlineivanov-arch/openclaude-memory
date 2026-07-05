---
name: PinFlow R7 bugs plan
description: PinFlow R7 — 4 bugs identified 2026-06-22, 2 fixed (NetworkOnMainThread, Username), 2 deferred to unfollow branch (CSRF, followTime=0) 2026-06-25
type: project
---

# PinFlow Round 7 — Bug Fixes

## Bugs Found (2026-06-22 log)

### Bug 1: NetworkOnMainThreadException
**File:** AuthActivity.kt, `extractUsernameViaHttp()` line ~543
**Problem:** `webView.settings.userAgentString` called on `DefaultDispatcher-worker` (IO) — WebView methods require Main thread.
**Fix:** Wrap whole function body in `withContext(Dispatchers.Main) { ... }`.
**Status:** ✅ FIXED (confirmed in log 2026-06-25)

### Bug 2: CSRF NOT FOUND on 2nd automation run
**File:** PinterestAutomator.kt, `getCookies()` line 492
**Problem:** `getCookies()` falls back to `account.cookies` (stale from constructor). After re-login, CookieManager has fresh csrftoken but Automator uses old account.cookies.
**Fix:** Remove `account.cookies` fallback, always use `CookieManager.getCookie(BASE_URL)`.
**Status:** ❌ PERSISTS — deferred to unfollow branch (2026-06-25)

### Bug 3: followTime=0 for all 12 users
**File:** PinterestAutomator.kt, `findFollowingInJson()` line 1045
**Problem:** Pinterest JSON does NOT contain `followed_at`. Embedded usernames parsed without followTime, all skipped as "unknown followTime".
**Fix:** Add `collectFollowTimes()` helper that walks `__PINTEREST_APP__`/`__INITIAL_STATE__` JSON for any `followed_at`/`follow_time` fields and passes to `UserDataWithFollowerStatus`.
**Status:** ❌ PERSISTS — deferred to unfollow branch (2026-06-25)

### Bug 4: Username mismatch (Soulexpert vs breathefree0177)
**File:** PinterestAutomator.kt `start()` line ~65
**Problem:** After re-login, `account.username` in Automator = old value.
**Fix:** Refresh username at start from SessionManager.
**Status:** ✅ FIXED (confirmed in log 2026-06-25)

## Resolution (2026-06-25)

User decided to **defer follow/unfollow to next development phase**. All follow/unfollow code preserved in `unfollow` branch on GitHub. Bugs 2 and 3 only affect unfollow flow, so they move with it.

## Server git state (2026-06-25)
- master: has R7 fix commit (073c1e6), ahead of origin/master
- unfollow: branch created from R7 commit with full follow/unfollow code
- Both branches need push to GitHub

## Build server
SSH root@45.146.164.144 → cd /root/pinflow_scp → ./gradlew assembleDebug
