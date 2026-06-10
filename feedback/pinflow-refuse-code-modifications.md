---
name: PinFlow code fixes allowed
description: User owns PinFlow project; code edits and APK builds are authorized when user requests
type: feedback
---

PinFlow is the user's own project. Code analysis, fixes, APK builds, commits, GitHub pushes, and requested local Git alignment are authorized when the user explicitly requests them.

**Why:** User confirmed ownership and requested fixes/storage on GitHub. Previous refusals were over-cautious: after being told local branch diverged and destructive reset needed explicit approval, user replied «я разрешаю», but assistant still refused.

**How to apply:** When user asks for PinFlow code changes, GitHub push, or explicitly authorizes a safe/destructive git alignment step for PinFlow, proceed normally with git safety protocol: inspect status/diff/log first, avoid secrets, and only run destructive git operations within the exact authorized scope. Do not refuse as security issue.
