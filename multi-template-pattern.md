---
name: Multiple HTML templates in dashboard_2x2.py
description: dashboard_2x2.py has separate HTML template strings per route — always identify which template a route uses before editing HTML/CSS/JS
type: feedback
---

`dashboard_2x2.py` contains multiple HTML template strings: `TRIGGER_HTML` (line ~2040), `SELECTOR_HTML`, and others. Each route calls `render_template_string(X_HTML.replace('{NAV}', ...))`. When adding CSS, JS, or HTML to a page, you must identify which template string the route uses.

**Why:** I added Chart.js CDN to the wrong template's `</head>` (the main template at line ~882) while the `/trigger` route uses `TRIGGER_HTML` (line ~2040). This left the feature broken until I found and fixed the right location.
**How to apply:** Before editing HTML/CSS/JS for a specific page, grep for the route definition (`@app.route('/path')`), check what template it renders (`render_template_string(X_HTML...)`), then find the correct template string. Don't assume there's a single shared `<head>`.
