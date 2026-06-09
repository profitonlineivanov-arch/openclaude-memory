---
name: PinFlow Android Download Path
description: User preference for PinFlow APK delivery in Termux/Android
type: feedback
---
Always copy APKs to `/sdcard/Download/` (the standard Android Downloads folder) instead of `~/downloads/` or other internal Termux paths.

**Why:** The user cannot easily access files in Termux internal directories from the Android OS/File Manager.
**How to apply:** When delivering APKs to the user, ensure the destination is the shared storage `/sdcard/Download/`.
