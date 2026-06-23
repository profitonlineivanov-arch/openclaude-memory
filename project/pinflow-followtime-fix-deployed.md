---
name: PinFlow followTime fix deployed
description: followTime fix deployed but log analysis shows 3 persisting bugs: NetworkOnMainThread, CSRF NOT FOUND, followTime=0 (2026-06-22)
type: project
---

fix(unfollow): use real followTime from HTML __INITIAL_STATE__

Changes in PinterestAutomator.kt:
1. UserDataWithFollowerStatus.followTime — new field (default 0L)
2. findFollowingInJson — extracts followed_at into followTime
3. HTML fallback — parse window.__PINTEREST_APP__ / __INITIAL_STATE__
4. executeUnfollowTask — prefers user.followTime, skips unknown followTime safely
5. extractJsonFromHtml helper — brace-matching JSON extractor

Build:
- AuthActivity suspend fix added
- APK: /sdcard/Download/pinflow-followtime.apk (8.6 MB)
- Server build: 45.146.164.144

Testing 2026-06-22 — log analysis results (pinflow_log_20260622_071854.txt):

**3 bugs still present:**

1. **NetworkOnMainThreadException** — `extractUsernameViaHttp()` line 539 AuthActivity calls `webView.settings.userAgentString` on `Dispatchers.IO`. WebView methods = main thread only. Previous fix only wrapped `client.newCall()` in `withContext(IO)`, but `webView.settings` call is BEFORE that.
   - **How to apply:** Move `val userAgent = webView.settings.userAgentString` to before `withContext(Dispatchers.IO)` block, or capture it on Main thread first.

2. **CSRF NOT FOUND on second run** — Second automation launch loses CSRF token from cookies. FollowingResource GET returns HTML/403 without `X-CSRFToken`. Race condition or cookie staleness after re-login.
   - **How to apply:** Verify cookies are refreshed between automation cycles. Check if `getCookies()` picks up fresh csrf after re-auth.

3. **followTime=0 for ALL 12 users** — `UserDataWithFollowerStatus.followTime` always 0. Pinterest FollowingResource doesn't return `followed_at`. `followedUsers` SharedPreferences empty (manual follows before app). Result: all users skipped ("unknown followTime"), 0 unfollows.
   - **Root cause:** HTML `__INITIAL_STATE__` parsing doesn't extract `followed_at`, or following list comes from mock/empty data, not real following.
   - **How to apply:** Need to verify HTML fallback actually parses real following data with timestamps. If Pinterest doesn't expose `followed_at`, need alternative (e.g., record followTime when automator follows, accept unknown for pre-existing).

**Bonus bug: username mismatch** — logged in as `breathefree0177`, automator ran with `Soulexpert`. `account.username` not updated after re-login.
