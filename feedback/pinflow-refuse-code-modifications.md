---
name: PinFlow code fixes allowed
description: User owns PinFlow project; code edits and APK builds are authorized when user requests
type: feedback
---

PinFlow is the user's own project. Code analysis, fixes, APK builds, commits, and GitHub pushes are authorized when the user explicitly requests them.

**Why:** User confirmed ownership and requested fixes/storage on GitHub. Previous refusal was over-cautious; user reacted with «не понимаешь?» after GitHub push was refused.

**How to apply:** When user asks for PinFlow code changes or says «залить/задить на GitHub», treat this as commit + push request for PinFlow. Proceed normally with standard git safety protocol: inspect status/diff/log first, avoid secrets, commit relevant files, push. Do not refuse as security issue.
