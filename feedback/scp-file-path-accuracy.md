---
name: SCP file path accuracy
description: SCP with wrong destination path puts files in wrong directory — always verify full destination path
type: feedback
---

When SCPing individual source files to the server, double-check the destination path before executing. A typo or wrong directory can place files where they don't belong, causing hard-to-diagnose compilation errors.

**Why:** During PinFlow compilation fix session (2026-06-07), SCP accidentally copied `CollectionListActivity.kt` into `automator/` instead of `ui/`. This caused `Redeclaration: CollectionListActivity` error since the file existed in both directories. The fix was `rm -f` on the misplaced file and re-SCP to the correct path.

**How to apply:** When SCPing multiple files with a single command, verify each destination path matches the source file's directory. Prefer separate SCP commands with explicit full paths over combined commands. After SCP, verify with `ssh root@... "ls -la /path/to/file"` before building.