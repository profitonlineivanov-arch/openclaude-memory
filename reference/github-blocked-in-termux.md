---
name: GitHub blocked in Termux
description: WebFetch resolves GitHub/raw.githubusercontent.com to private IPs (10.x.x.x) in Termux network
type: reference
---

**GitHub domains inaccessible from Termux network.**

WebFetch resolves both `github.com` and `raw.githubusercontent.com` to private/link-local IP addresses in the 10.x.x.x range. HTTP requests are blocked at the hook level with "private/link-local address" error.

This affects:
- Fetching repo READMEs, files, or API data from GitHub via WebFetch
- Raw content URLs (`raw.githubusercontent.com`)  
- Any gh CLI operations that depend on network reachability (if gh not authenticated)

**Workaround:**
- Use `gh` CLI if authenticated (but gh auth login requires device flow in Termux)
- Use remote server (45.146.164.144) for GitHub operations via SSH — server has different network
- Write what's needed from memory/knowledge rather than fetching from GitHub

**Why:** Likely Android/Termux DNS or routing quirk. Not a permanent network policy — WebFetch passes GitHub URLs in other environments (Windows, macOS).

**How to apply:** When needing GitHub content (gstack prompts, etc.), either use remote server or rely on analysis already done rather than retrying WebFetch.
