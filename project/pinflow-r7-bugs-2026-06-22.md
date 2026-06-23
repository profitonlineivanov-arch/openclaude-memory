---
name: PinFlow R7 bugs plan
description: PinFlow Round 7 — 4 bugs identified 2026-06-22, fix attempt in progress 2026-06-23
type: project
---

# PinFlow Round 7 — Bug Fixes

## Bugs Found (2026-06-22 log)

### Bug 1: NetworkOnMainThreadException
**File:** AuthActivity.kt, `extractUsernameViaHttp()` line ~543
**Problem:** `webView.settings.userAgentString` called on `DefaultDispatcher-worker` (IO) — WebView methods require Main thread.
**Fix:** Wrap whole function body in `withContext(Dispatchers.Main) { ... }`.

### Bug 2: CSRF NOT FOUND on 2nd automation run
**File:** PinterestAutomator.kt, `getCookies()` line 492
**Problem:** `getCookies()` falls back to `account.cookies` (stale from constructor). After re-login, CookieManager has fresh csrftoken but Automator uses old account.cookies.
**Fix:** Remove `account.cookies` fallback, always use `CookieManager.getCookie(BASE_URL)`.

### Bug 3: followTime=0 for all 12 users
**File:** PinterestAutomator.kt, `findFollowingInJson()` line 1045
**Problem:** Pinterest JSON does NOT contain `followed_at`. Embedded usernames parsed without followTime, all skipped as "unknown followTime".
**Fix:** Add `collectFollowTimes()` helper that walks `__PINTEREST_APP__`/`__INITIAL_STATE__` JSON for any `followed_at`/`follow_time` fields and passes to `UserDataWithFollowerStatus`.

### Bug 4: Username mismatch (Soulexpert vs breathefree0177)
**File:** PinterestAutomator.kt `start()` line ~65
**Problem:** After re-login, `account.username` in Automator = old value. `startAutomation()` in MainActivity passes `effectiveAccount` from DB, but after re-auth session may be stale.
**Fix:** Refresh username at start: `val freshUsername = SessionManager(context).getUserName() ?: account.username; this.account = account.copy(username = freshUsername)`.

## Fix Attempt (2026-06-23, in progress)

### Round 1: 4 Python patches via SSH heredoc — FAILED
- Wrote patch1.py..patch5.py via `cat > /tmp/patch.py << 'EOF'` in SSH heredocs
- Nested quotes (`\"`, `${...}`) broke bash escaping — patches 3 and 4 failed immediately
- Applied 3 patches that did run, built:
  - **Compile error:** `AuthActivity.kt:587:19 Expecting ')'` — patch1 inserted `withContext(Dispatchers.Main) {` but `return try {` followed — unbalanced
  - **Duplicate line:** patch4 inserted `val freshUsername` twice
- **Restored from .bak** (backups at *.bak and *.bak2)

### Round 2: Write locally, SCP, run (in progress)
- Write `apply_fixes.sh` locally via Write tool → SCP to server → bash on server
- **Why:** avoids all nested-quote hell with heredocs
- Script applies 5 sed rules for all 4 bugs
- **User interrupted** before SCP+execute completed

## Files to modify
- /root/pinflow_scp/app/src/main/java/com/pinflow/ui/AuthActivity.kt (Bug 1)
- /root/pinflow_scp/app/src/main/java/com/pinflow/automator/PinterestAutomator.kt (Bug 2, 3, 4)

## Build server
SSH root@45.146.164.144 → cd /root/pinflow_scp → ./gradlew assembleDebug

## APK delivery
scp to /sdcard/Download/pinflow-r7.apk

## Status (2026-06-23)
**In progress.** Round 1 failed compile. Restored from .bak. Round 2: apply_fixes.sh written locally at `/data/data/com.termux/files/home/apply_fixes.sh`, needs SCP to server + execute + rebuild + APK delivery.

## Lessons
- PinFlow Kotlin source has `$` and `\"` everywhere — never send fix patches via SSH heredoc.
- Always: Write locally → SCP → run on server. (Matches existing ssh-quoting-workaround rule.)
- Patch spray (sed/Python with complex escaping) unreliable for Kotlin. Better: `Read` server file → `Write` new version locally (with exact changes) → SCP over.
