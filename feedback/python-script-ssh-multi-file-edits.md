---
name: Python script via SSH for multi-file edits
description: For complex multi-file code removals on remote server, write Python script locally, SCP to server, run. sed/regex over SSH unreliable for nested function blocks.
type: feedback
---

Python script executed via SSH handles multi-file edits better than chained sed commands. Write script locally → SCP to server → python3 script.py.

**Why:** Nested Kotlin function blocks (brace-matched) break with regex/sed. SSH quoting makes inline scripts fragile. Python with file read/write + regex is more reliable for surgical removals across 10+ files.

**How to apply:** For any remote server edit touching 5+ files or removing nested code blocks: write Python script, SCP to /root/, execute. But ALWAYS verify after — regex can miss nested functions or leave residual code (e.g. PinterestAutomator.kt had followTimeMap + UserDataWithFollowerStatus left behind, PinterestWorker.kt got mangled by prior sed).

**Caveat:** sed for simple line deletions (single matching string per line) is fine. Python scripts for anything involving brace-depth or multi-line block removal. Always `grep -rn` after to verify no references remain. **ALWAYS build after edits** — Python line-by-line removal of XML elements (like SwitchMaterial tags) can leave malformed XML (unclosed tags, orphaned attributes). Line-by-line filtering doesn't understand XML nesting.
