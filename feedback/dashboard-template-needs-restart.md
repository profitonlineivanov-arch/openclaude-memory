---
name: Dashboard in-memory templates need restart
description: HTML templates in dashboard_2x2.py as module-level strings (SELECTOR_HTML, TRIGGER_HTML etc.) require process restart after edit
type: feedback
---

When editing SELECTOR_HTML, TRIGGER_HTML, MORSE_HTML, or any module-level HTML template string in `dashboard_2x2.py`, the running Flask process must be restarted — these are in-memory Python string constants loaded at import time, not file-based templates.

**Why:** Unlike the /timing page which reads an external HTML file via `open()`, the existing pages embed their HTML as Python string variables at module scope. The running process holds the old string in memory.

**How to apply:** After editing any module-level HTML template (`SELECTOR_HTML = '''...'''` etc.), kill the python dashboard process and restart with nohup. Files in `templates/` dir don't need restart.
