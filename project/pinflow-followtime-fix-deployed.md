---
name: PinFlow followTime fix deployed and tested
name: PinFlow followTime fix deployed and tested
description: followTime fix implemented, built, and APK tested. Logs exported for analysis (2026-06-22)
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

Testing:
- User launched app → ran unfollow automation → exported logs
- Status: awaiting log analysis (2026-06-22)
