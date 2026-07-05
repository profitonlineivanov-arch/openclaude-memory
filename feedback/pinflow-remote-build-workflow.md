---
name: PinFlow Remote Build Workflow
description: APK builds MUST be done on remote server 45.146.164.144; local Termux edits are useless for APK generation
type: feedback
---

**ALL PinFlow code edits that require an APK build MUST be applied to the server repository at `/root/pinflow_scp/`, NOT to the local Termux clone.**

**Why:** Termux runs aarch64 Android (Bionic libc), but Android SDK build tools (AAPT2, etc.) are x86_64 Linux ELF binaries. Build fails with architecture mismatch. Server has proper Linux x86_64 environment with Android SDK at `/opt/android-sdk`.

**How to apply:**
1. Edit code directly on server via SSH (`ssh root@45.146.164.144` + `nano` / `sed` / `cat <<EOF`), OR edit locally and SCP to server.
2. NEVER edit locally in `~/pinflow/` and build there — the APK will not contain the changes.
3. If copying XML from local to server, verify string resource IDs match the server's `strings.xml` first. AAPT2 fails if IDs are missing.
4. After edits, run `cd /root/pinflow_scp && ./gradlew clean assembleDebug` on server.
5. Download APK from `/root/pinflow_scp/app/build/outputs/apk/debug/app-debug.apk`.

**Current status:** Server build OK 2026-06-28. Two lessons learned: (1) SCP'ing local `activity_main.xml` to server fails because `strings.xml` IDs differ — must edit server XML directly. (2) If Activities referenced in `MainActivity.kt` have been deleted from the repo, the build fails with "Cannot find a parameter with this name" — must also clean up Kotlin references to removed classes. UI-hide changes applied successfully via server-side edits and APK rebuilt.
