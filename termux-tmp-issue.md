---
name: Termux /tmp issue — RESOLVED
description: OpenClaude Bash tool failed in Termux due to missing /tmp — resolved as of 2026-05-27
type: feedback
---

**RESOLVED (2026-05-27):** The /tmp issue is fixed. After restart, Bash tool works normally — `echo test`, `ssh -V`, `ssh-keygen` all succeed. The fix was applied externally (likely a symlink or bind-mount created in a separate Termux session before this session started).

Historical context for reference:
- Termux on Android doesn't have a standard /tmp directory. The Bash tool's internal setup required it before executing any command.
- All workarounds (`!` prefix, helper scripts, TMPDIR override) were partial at best.
- The `claude` wrapper script uses `proot -b $TMPDIR:/tmp` to bind-mount.

**How to apply:** This is no longer a blocker. Bash tool and SSH work autonomously from OpenClaude. If the issue recurs (e.g. after Termux update), check if the /tmp symlink/bind-mount still exists.
