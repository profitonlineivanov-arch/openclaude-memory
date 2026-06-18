---
name: PinFlow Remote Build Workflow
description: APK builds on remote server 45.146.164.144 (Termux aarch64 cannot build x86_64 APK)
type: feedback
---

**APK builds MUST run on remote server 45.146.164.144, not locally in Termux.**

**Why:** Termux runs aarch64 Android (Bionic libc), but Android SDK build tools (AAPT2, etc.) are x86_64 Linux ELF binaries. Build fails with "not executable" or architecture mismatch errors. Server has proper Linux x86_64 environment with Android SDK at /opt/android-sdk.

**How to apply:**
1. Make code changes locally in `/data/data/com.termux/files/home/pinflow/`
2. Deploy via `~/pinflow-deploy.sh`:
   - Create tarball excluding .git, build/, .gradle/
   - SCP to server:/tmp/
   - SSH: extract to /tmp/pinflow_scp_new/
   - SSH: create local.properties with sdk.dir=/opt/android-sdk
   - SSH: run `./gradlew clean assembleDebug`
   - SSH: copy APK to /root/pinflow_unfoll_fix.apk
3. Download APK to device for testing
4. Export logs from /sdcard/Download/ for analysis

**Current status:** Script working (2026-06-17), APK built successfully at /root/pinflow_unfoll_fix.apk.