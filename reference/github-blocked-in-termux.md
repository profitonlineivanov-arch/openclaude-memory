---
name: GitHub blocked in Termux (RESOLVED 2026-07-06)
description: GitHub was blocked in Termux network, now confirmed working for npm install
type: reference
---

**GitHub domains were inaccessible from Termux network — NOW RESOLVED.**

**Was:** WebFetch resolved both `github.com` and `raw.githubusercontent.com` to private/link-local IP addresses in the 10.x.x.x range. HTTP requests were blocked at the hook level with "private/link-local address" error.

**RESOLVED 2026-07-06:** GitHub is NOT blocked anymore. Confirmed same day — network access works for npm install, git clone etc.

**Caveat — npm install failures might still be PLATFORM-related, not network:**
- `npm install -g ruflo` failed with `EBADPLATFORM` — ruflo's `@claude-flow/memory` doesn't support android
- This is a package.json `os` field restriction, NOT a network block
- Diagnose: if `npm install` fails, check whether error says `EBADPLATFORM` (platform) vs timeout/DNS (network)

This had affected:
- Fetching repo READMEs, files, or API data from GitHub via WebFetch
- Raw content URLs (`raw.githubusercontent.com`)  
- Any gh CLI operations that depend on network reachability

**2026-07-06 — additional nuance:** `npm install -g ruflo --force` hangs indefinitely on Termux (Android). This is NOT the EBADPLATFORM error — it hangs at download stage. `npm install ruflo` (local, not global) was not tested. The reliable workaround is to copy the package from another device. This may be related to npm on Android having issues with large package installation, not network — curl/manual downloads work fine.

**Workaround (now likely unnecessary):**
- Use remote server (45.146.164.144) for GitHub operations via SSH — server has different network
- Write what's needed from memory/knowledge rather than fetching from GitHub

**Why was it blocked?** Likely Android/Termux DNS or routing quirk, now resolved.

**How to apply:** Assume GitHub works in Termux unless proven otherwise. If `npm install` fails with `EBADPLATFORM` — it's a package compatibility issue, not network. If timeout/DNS error — network is blocked.
