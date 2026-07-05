---
name: Proxy to distinguish blocked vs dead sites in Russia
description: Use external HTTP proxy to tell whether a timeout site is actually dead or just blocked by RKN (2026-07-05)
type: feedback
---

From Russia (Termux), curl timeout = blocked by RKN (alive outside) OR truly dead. Use external proxy to distinguish.

**How to apply:** When checking site availability from RF: first try direct (timeout tells nothing), then retry through user-provided external HTTP proxy. If alive through proxy = blocked. If DEAD (000) through proxy too = truly dead. Ask user for proxy details before starting bulk checks.

**Why:** Without proxy, ~50+ sites in relevant Wikipedia articles all look "dead" (timeout) but ~80% are just RKN-blocked and still alive. False positives waste effort.

Tested with: `curl -sI --proxy "http://user:pass@proxy:port" --max-time 10 "$url"`
User proxy: 138.59.207.154:9963 HTTP (credentials provided by user per session).