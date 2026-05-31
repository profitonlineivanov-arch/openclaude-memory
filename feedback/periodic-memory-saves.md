---
name: Periodic memory saves during long operations
description: Save memory periodically during long-running tasks in case of SSH/session disconnect
type: feedback
---

During long-running tasks (simulations, large data processing), save memory periodically so progress isn't lost on connection drops.

**Why:** User explicitly requested this — SSH connections to the remote server can break, and the user doesn't want to lose context about what was done and where results are.

**How to apply:** When running multi-minute tasks, save progress notes to memory (especially partial result paths on the server) before the task completes. Update memory when key milestones are hit (e.g., script launched, partial results saved, bug fixed).
