---
name: multi-device-config
description: Multi-device setup caveats — Termux (Android) + Windows laptop, platform-specific config paths
type: feedback
---

When syncing configs between Termux and Windows, `settings.json` `env` section must use platform-specific paths. The Termux config has paths that don't exist on Windows and vice versa.

**Current issue (2026-06-14):** Laptop `settings.json` still has Termux env paths:
```json
"env": {
  "TMPDIR": "/data/data/com.termux/files/home/tmp",
  "CLAUDE_CODE_TMPDIR": "/data/data/com.termux/files/home/tmp"
}
```
These must be changed to `%TEMP%` on Windows, or the `env` block removed entirely (Windows handles TMPDIR natively).

**Why:** Synced configs contain absolute paths that are platform-specific. Copying configs between devices without adjusting `env` causes broken temp directory references.

**How to apply:** After `sync.sh pull` on a new device, check and fix `settings.json` `env` section. On Windows: replace Termux paths with `%TEMP%` or remove `env` block. On Termux: ensure paths match the Termux home tree.
