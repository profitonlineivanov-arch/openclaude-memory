---
name: PinFlow followTime fix
description: followTime always 0 because Pinterest doesn't provide it in FollowingResource
type: feedback
---

# PinFlow: followTime=0 Root Cause

Pinterest FollowingResource JSON **does not contain** follow time. `ft` field is always 0. `followedUsers` SharedPreferences map also empty for manual follows.

**Fix options:**
1. Drop followTime requirement, use `isFollower == false` only as unsub trigger
2. Fetch followTime from separate endpoint (e.g., PinnerFollowingResource or parse from profile page)
3. Accept manual followTime entries or scan history

**Why it matters:** All 12 users skipped → 0 unfollows. Unfollow loop useless without follow time.

**Recommendation:** Option 1 (simplest) — unfollow ALL non-followers regardless of age, or unfollow by age threshold stored locally.