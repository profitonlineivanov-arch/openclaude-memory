---
name: Remote server connection
description: SSH access to 45.146.164.144 — use root@ (not openclaw@), non-interactive only
type: project
---

Server 45.146.164.144 (hostname `egippjjodq`). **Always connect as `root@`**, not `openclaw@`:
- `ssh root@45.146.164.144` — passwordless via ED25519 key (set up 2026-05-27)
- `openclaw@` user has no home dir (`/home/openclaw` missing) — causes "Could not chdir" and broken pipe
- Non-interactive mode only: `ssh root@... "command"` — interactive shells drop within seconds

**Projects on server:**
- `/root/projects/2x2` (lottery predictor, v8)
- `/root/projects/1224` (12 из 24 lottery)
- `/root/projects/4x20` (4x20 lottery dashboard, port 8080)
- Python venvs: `/root/venvs/2x2/`, etc.

**SSH key:** ED25519 in Termux `~/.ssh/id_ed25519`, public key in `/root/.ssh/authorized_keys` on server.

**Known issues:**
- Disk **82% used of 14 GB, 2.6 GB free** (verified 2026-06-07) — почти заполнен. Установка Android SDK + build-tools (≈1.5 GB) впритык, требует предварительной очистки `/opt` и/или `/tmp`.
- Ubuntu 24.04.4 LTS, kernel 6.8.0-106-generic
- Search specific dirs only: `find /home /root /opt /var/www /srv -maxdepth 3` (never `find /`)

**Android SDK (установлен 2026-06-07 для сборки PinFlow):**
- `/opt/android-sdk/` — cmdline-tools/latest, platforms;android-34, build-tools;34.0.0
- OpenJDK 17 (`java-17-openjdk`)
- PinFlow проект: `/root/pinflow/` (клонирован из GitHub)
- Сборка: `cd /root/pinflow && ./gradlew assembleDebug`
- APK output: `/root/pinflow/app/build/outputs/apk/debug/app-debug.apk`

**PinFlow build attempt 2026-06-07:** AAPT2 fails in Termux because `~/android-sdk/build-tools/34.0.0/aapt2` is **x86-64 ELF** (`file` says: "ELF 64-bit LSB pie executable, x86-64") but Termux runs on **aarch64 Android**. Not a glibc/Bionic issue — pure architecture mismatch. Same for d8, zipalign, apksigner. Two options: build on x86_64 server (45.146.164.144) or download aarch64 build-tools from `dl.google.com/android/repository/`. Local Termux build is impossible.

**How to apply:** Always `ssh root@...` for commands. For long scripts: write locally, SCP, then `nohup python3 -u` in background. Check progress with `ps aux | grep` + `tail` on output file.
