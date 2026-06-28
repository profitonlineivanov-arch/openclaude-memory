---
name: PinFlow Local Repo Status 2026-06-28
description: Local ~/pinflow master at 18c2b94, server build failed after local→server SCP mismatch, UI hide not yet deployed
type: project
---

# PinFlow Local Repository Status — 2026-06-28 (updated)

Local repo at `~/pinflow` (Termux):
- **Branch:** master, up to date with `origin/master`
- **Latest commits:**
  - `18c2b94` — fix(auth): mark extractUsernameViaHttp as suspend
  - `040d221` — fix(unfollow): use real followTime from HTML __INITIAL_STATE__
  - `915c28a` — Implement parallel task execution in PinterestAutomator.
- **Uncommitted changes:** only `app-debug.apk` modified

**UI cleanup completed (2026-06-28 session):**
- Goal: remove broken follow/unfollow UI elements from `activity_main.xml` because FollowingResource returns 100% 403 and the corresponding Activity classes (`FollowSettingsActivity`, `UnfollowSettingsActivity`) have been deleted from the repo.
- **Server-side changes applied:**
  - `activity_main.xml`: removed two empty `MaterialButton` elements (no `android:id` or `android:text`) that were left behind after previous string-resource removals.
  - `MainActivity.kt`: removed all references to `FollowSettingsActivity`, `UnfollowSettingsActivity`, `switchAutoFollow`, `switchAutoUnfollow`, `statsFollows`, `statsUnfollows` (including `findViewById`, `setOnClickListener`, `loadSettings`, `copy()`, and `updateStats()` calls).
- **Build result:** `BUILD SUCCESSFUL` after `clean assembleDebug`. Warnings only (deprecated methods, unused parameter).
- **APK delivered:** `pinflow-r8.apk` installed on Android device via `termux-open`.

**Lessons:**
- Editing locally and SCP'ing XML to server fails when `strings.xml` IDs differ — must edit server XML directly.
- Removing Activities from repo without cleaning up references in `MainActivity.kt` causes compilation failure.
- `switchAutoFollow.isChecked = false` was already present in server `MainActivity.kt` (line 128), so that part was already in place.
