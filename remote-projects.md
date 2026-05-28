---
name: Remote server projects
description: Three lottery analytics projects (2x2, 1224, 4x20) on remote server 45.146.164.144 — Python/SQLite dashboards and parsers
type: project
---

Three lottery analytics projects hosted on remote server at 45.146.164.144, all under `/root/projects/`. Each has its own Python venv in `/root/venvs/`. All repos have `.git/` directories and are owned by group `openclaw` (uid=1000).

**2x2** (port 5000): Lottery analysis system with parser (`parser_v6.py`), dashboard (`dashboard_2x2.py` — 134KB, running as user `hermes`), rarity index, triple beam analyzer, horizontal selector, trigger analyzer, and beams API. SQLite database in `database/`. Config in `config_v5.yaml`. Has Google Sheets integration (`google_sheets_v4.py`). Currently running: `dashboard_2x2.py` (pid 1628863).

**1224** (port 5555): Lottery analysis system with parser (`parser_1224.py`), unified dashboard (`unified_dashboard.py`), chaos analyzer (`dashboard_chaos.py`), v5 analyzer subsystem. Large SQLite DB (~212MB `lottery_1224.db`). Has proxy management for web scraping. Currently running: `parser_1224.py` (pid 323984) and `unified_dashboard.py` (pid 2532123).

**4x20** (port 8080): Lottery analysis with parser (`parser_4x20.py`), dashboard (`dashboard.py`), SQLite database. Currently running: `dashboard.py` (pid 4142341).

Also on server: ~~gpt2giga proxy on port 8443~~ (stopped 2026-05-24 by user request), fail2ban, tailscale VPN, vsftpd (port 21), CUPS print service.

**Why:** User works on these projects across sessions and expects continuity. These are the primary active projects.

**How to apply:** When user asks to work on "2x2", "1224", or "4x20", connect to the remote server via SSH. Use `root` access with `su - openclaw` for file operations. All projects are Python-based with SQLite backends and Flask/dash web dashboards.

**Cleanup (2026-05-24):** Removed old AI tool directories from server: `/root/.hermes` (23MB), `/root/.openclaw` (256KB), `/root/projects/2x2/.qwen` (~20KB). These were leftovers from previous AI assistants (Hermes, OpenClaw, Qwen/Cline).
