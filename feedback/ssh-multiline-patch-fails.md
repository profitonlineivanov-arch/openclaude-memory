---
name: SSH multiline patch fails
description: Python heredoc replace() over SSH fails on whitespace for server-side Kotlin files — use sed or line-by-line instead
type: feedback
---

Python `str.replace()` with multiline old/new blocks passed via SSH heredoc silently fails to match — whitespace/encoding drift between heredoc and actual file content.

**Why:** 3 consecutive patch attempts with multiline `replace()` in Python heredoc over SSH all returned "not found" or "patch missing" despite showing correct source lines in `cat` output. Single-line replacements and `sed` work fine.

**How to apply:** For patching server files via SSH: use `sed -i` for single-line changes, or write a Python script to a local file, SCP it, then run — never embed multiline string replacements in an SSH heredoc.
