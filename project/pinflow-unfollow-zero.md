---
name: PinFlow Unfollow Bug
description: 2026-06-23 code-level root causes found for auto-unfollow failure; fix in progress
type: project
---

## Status: FIX IN PROGRESS (2026-06-23)

Patch attempt started but blocked by SSH multiline replace failures. Bug NOT yet fixed in code.

## Root causes identified in PinterestAutomator.kt

### Bug 1: Wrong user identity in `findFollowingInJson` (line 1066-1089)
- `id` field from JSON is `/User/12345` resource-style path, not numeric `user_id`
- Pinterest `user_id` is a separate field in the JSON — code doesn't read `user_id` or `user_id_str`
- Fix: add `val rawUserId = json.optString(“user_id”, json.optString(“user_id_str”, id))` and use it as primary id

### Bug 2: Kotlin char literal in `unfollowUser` (line 1125)
- `userId.removePrefix(“/User/”).trim(/)` — `trim(/)` is INVALID Kotlin (bare char literal)
- Should be `trim('/')` with single-quote char
- This likely causes compile error or runtime crash

### Bug 3: `isFollower` semantic confusion (line 1086)
- `isFollower = json.optBoolean(“follows_me”, false) || json.optBoolean(“is_follower”, false)` means “they follow us”
- For following-list users, this is almost always false — but the unfollow loop at line 474 doesn't gate on it, so this is informational not blocker

## Patch approach
- Add `rawUserId` extraction in `findFollowingInJson`
- Fix `trim(/)` → `trim('/')` in `unfollowUser`
- **Blocked**: Python heredoc multiline `replace()` via SSH fails on whitespace matching — need `sed` or line-by-line approach

**Why:** Fresh investigation on 2026-06-23 found concrete code-level bugs, not architectural issues. Earlier theory (“FollowingResource fundamentally unusable”) is superseded.

**How to apply:** Fix the two concrete code bugs (rawUserId + trim literal). Don't rewrite the unfollow endpoint path. After patching, rebuild APK on server.
