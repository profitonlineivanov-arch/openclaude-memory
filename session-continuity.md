---
name: Session continuity after crashes
description: User expects to resume context from crashed sessions and may forward responses from other AIs for continuity
type: feedback
---

When a session crashes or is lost, the user will try to resume by reminding the assistant what was discussed and may forward responses from other AI agents they consulted in the meantime.

**Why:** The user works across multiple AI agents and mobile sessions are fragile (Termux, /tmp issues, JS heap OOM). Context loss is frequent.
**How to apply:** When the user says "напомню что ты писал" or similar, wait for them to share the previous context before acting. Don't assume you know what happened — ask them to show you. Confirmed pattern (2026-05-26): user shared my diagnostic from a prior session + forwarded another AI's proposed fix. I reviewed both and cross-referenced against my existing memory to avoid repeating failed approaches. Confirmed (2026-05-27): user pasted crash log showing JS heap OOM during SCP/dashboard work — I verified all changes survived on the server and confirmed feature was deployed. Confirmed again (2026-05-27): session crashed with JS heap OOM during AC stats work — user pasted the tail end of the previous session, I picked up where it left off (Chart.js CDN was missing).
