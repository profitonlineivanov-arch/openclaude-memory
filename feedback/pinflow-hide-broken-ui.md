---
name: PinFlow Hidden Follow/Unfollow UI
description: Follow/unfollow switches and settings buttons hidden from MainActivity because FollowingResource API is blocked (100% 403)
type: feedback
---

**Rule:** When Pinterest web API endpoints return consistent 403/Auth errors and the feature cannot be made to work via any known workaround, completely remove the related UI controls and their Kotlin references rather than leaving them visible or hiding them with `visibility="gone"`.

**Why:** User reported empty spaces in settings after previous removals. The root cause was two-fold: (1) `FollowSettingsActivity` and `UnfollowSettingsActivity` classes had been deleted from the repo, but `MainActivity.kt` still referenced them, causing compilation errors. (2) The XML still contained two empty `MaterialButton` elements without `android:id` or `android:text`, which rendered as blank rows on the screen. The correct fix is to remove both the Kotlin references and the empty XML elements entirely.

**How to apply:**
- In `activity_main.xml`: delete any `MaterialButton` elements that have no `android:id` or `android:text` (these are leftover skeletons from removed features).
- In `MainActivity.kt`: remove all `findViewById` calls, `setOnClickListener` blocks, `loadSettings` overrides, and `updateStats` references for the removed features. Also remove `import` statements for deleted Activity classes.
- Do NOT use `android:visibility="gone"` if the Activity classes have been deleted — the Kotlin references will break the build anyway.
- If the Activity classes still exist, `visibility="gone"` is acceptable as a temporary measure.

**Context:** FollowingResource 100% 403 confirmed since 2026-06-25. All follow/unfollow API attempts blocked by Pinterest. The `FollowSettingsActivity` and `UnfollowSettingsActivity` Kotlin source files were previously removed from the repository (likely in the unfollow branch), but `MainActivity.kt` was not updated, leading to build failures when trying to compile with the deleted classes. Removing the XML buttons alone was insufficient because the Kotlin code still referenced the missing IDs and Activities.
