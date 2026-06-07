---
name: PinFlow build on server
description: PinFlow project is at /root/pinflow_scp/pinflow/ on server (not /root/pinflow/)
type: project
---

PinFlow Android project is at `/root/pinflow_scp/pinflow/` on server 45.146.164.144 (not `/root/pinflow/` as previously documented).

**Build command:**
```
ssh root@45.146.164.144 "cd /root/pinflow_scp/pinflow && export ANDROID_HOME=/opt/android-sdk && ./gradlew assembleDebug --no-daemon 2>&1"
```

**APK location on server:** `/root/pinflow_scp/pinflow/app/build/outputs/apk/debug/app-debug.apk`

**SCP to Termux:**
```
scp root@45.146.164.144:/root/pinflow_scp/pinflow/app/build/outputs/apk/debug/app-debug.apk /data/data/com.termux/files/home/pinflow-debug.apk
```

**local.properties** (needed for first build): `sdk.dir=/opt/android-sdk`

**Why:** The project is deployed under `/root/pinflow_scp/` (SCP'd copy). Previously documented as `/root/pinflow/` — that path may also work but the active copy is in `pinflow_scp`.

**How to apply:** Always use `/root/pinflow_scp/pinflow/` for SCP uploads and build commands. Create `local.properties` if missing (first build after fresh copy).