---
name: disk-cleanup-server
description: SSH server disk cleanup automation setup
type: project
originSessionId: e975ea4b-0ac4-4b4c-b4ec-1eaf5717fa5d
---
## SSH server cleanup task (2026-04-16)

**Server:** root@45.146.164.144

### Problem
- Disk 100% full (14G / 14G used)
- Root cause: snap old revisions, journal bloat, /tmp garbage

### Actions taken
1. **Manual cleanup:** freed ~2 GB (journal vacuum 321MB, snap revisions ~700MB, tmp files ~1.1GB)
2. **Automated cleanup installed:**
   - `/usr/local/bin/disk-cleanup.sh` — cleanup script
   - `/etc/systemd/system/disk-cleanup.service` — oneshot service
   - `/etc/systemd/system/disk-cleanup.timer` — hourly check, enabled
   - Threshold: 85% fill triggers cleanup
   - Cleanup actions: snap old revisions, journal vacuum to 100MB, /tmp cleanup, apt-get clean

### Final state
- 82% used, 2.6 GB free
- Timer active, next run in ~1h
