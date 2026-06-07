---
name: SCP recursive directory fails in Termux
description: scp -r fails for directories in Termux — use tar.gz archive instead
type: feedback
---

When copying project directories to the remote server (45.146.164.144), `scp -r ~/pinflow root@...:/root/` fails silently — files end up empty or partially transferred. Verification agents trying recursive SCP hit repeated permission denials.

**Why:** Termux's SSH/SCP environment (likely proot/bind-mount or filesystem layer) doesn't handle recursive directory transfers reliably.

**How to apply:** Use tar+gz instead:
1. `tar czf /data/data/com.termux/files/home/tmp/project.tar.gz --exclude='project/.gradle' --exclude='project/app/build' --exclude='project/app-debug.apk' project/`
2. `scp /data/data/com.termux/files/home/tmp/project.tar.gz root@45.146.164.144:/root/target/`
3. `ssh root@45.146.164.144 "cd /root/target && tar xzf project.tar.gz"`

Confirmed working 2026-06-07 for PinFlow project sync (360KB archive, excludes build artifacts).