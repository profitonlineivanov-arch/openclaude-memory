---
name: Termux Android build impossible
description: AAPT2 — x86_64 ELF на aarch64 Android. Сборка APK ТОЛЬКО на сервере 45.146.164.144.
type: feedback
---

**Правило:** Android APK для PinFlow собирать ТОЛЬКО на сервере 45.146.164.144 через SSH. Termux не поддерживает AAPT2 (архитектурная несовместимость x86_64 vs aarch64).

**Why:** `~/android-sdk/build-tools/34.0.0/aapt2` — x86_64 ELF, Termux на aarch64 Android. Невозможно запустить нативно. Та же проблема с d8, zipalign, apksigner.

**How to apply:**
1. `git push origin master` — локально или через GitHub
2. `ssh root@45.146.164.144 "cd /root/pinflow_scp/pinflow && git fetch origin && git reset --hard origin/master && ./gradlew assembleDebug --no-daemon"`
3. APK: `/root/pinflow_scp/pinflow/app/build/outputs/apk/debug/app-debug.apk`
4. Скачать через SCP пользователю