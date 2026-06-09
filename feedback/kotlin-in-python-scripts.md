---
name: kotlin-in-python-scripts
description: When writing Python fix scripts that embed Kotlin/Java, use separate .kt files — never Python string literals with escape sequences
type: feedback
---

**Rule:** When writing Python scripts that need to insert/replace Kotlin or Java code, NEVER embed the code in Python string literals. Write the target code in separate `.kt` files and read them with `open().read()`. This avoids Python escape sequence mangling.

**Why:** PinFlow `fix_username2.sh` used a `python3 -c` one-liner with Kotlin code inside Python triple-quotes. Kotlin escape sequences (`\"`, `\\`, `\u0026`) inside Python strings got mangled — `\\` became `\`, `\"` became `"`, breaking the output. Multiple rounds of fixing the fix script. Writing Kotlin as `.kt` snippet files and reading from Python avoided all escaping issues.

**How to apply:** Any fix script that touches Kotlin/Java/Android source files — write replacement code in dedicated `.kt` snippet files, read them in Python via `open("snippet.kt").read()`. For one-liner hotfixes over SSH, use `sed` or `perl -i` instead of Python if the change is simple.
