---
name: SSH quoting workaround for remote commands
description: Nested quotes break when SSHing to remote server — write script locally, SCP, then run
type: feedback
---

When running Python or complex commands on the remote server via SSH, nested quotes (double inside double, or escaped quotes) get mangled during transmission. Exit code 1 with no useful error output.

**Why:** SSH passes the command string through shell parsing on both ends. Complex quoting (especially with Python f-strings, dict literals, or sqlite3 queries) breaks in transit.

**How to apply:** Instead of trying to craft quote-safe one-liners:
1. Write the script locally to `/data/data/com.termux/files/home/tmp/`
2. `scp` it to the server (`/tmp/`)
3. Run it via SSH with simple invocation: `ssh root@... "source /root/venvs/.../bin/activate && python3 /tmp/script.py 2>&1"`
4. Capture stderr with `2>&1` — without it, errors are silently swallowed

Confirmed working pattern (2026-05-27): database inspection scripts for 2x2 project.
