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
- Disk ~86.3% of 13.49GB — near full (flagged 2026-05-27)
- Ubuntu 24.04.4 LTS, kernel 6.8.0-106-generic
- Search specific dirs only: `find /home /root /opt /var/www /srv -maxdepth 3` (never `find /`)

**How to apply:** Always `ssh root@...` for commands. For long scripts: write locally, SCP, then `nohup python3 -u` in background. Check progress with `ps aux | grep` + `tail` on output file.
