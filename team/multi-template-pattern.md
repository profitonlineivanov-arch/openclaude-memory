---
name: Multi-template pattern in dashboard_2x2.py
description: dashboard_2x2.py has separate HTML template strings per route — always identify which template a route uses before editing HTML/CSS/JS
type: feedback
---

Each route in `dashboard_2x2.py` renders its own template string (e.g. `TRIGGER_HTML`, `SELECTOR_HTML`, etc.) — they don't share a common `<head>` or layout.

**Why:** Chart.js CDN was added to the wrong template's `</head>` (line ~882) instead of `TRIGGER_HTML`'s `</head>` (line ~2126), causing the AC stats chart to silently fail. Wasted debugging time.

**How to apply:** Before editing HTML/CSS/JS in `dashboard_2x2.py`, always grep for which template variable the target route uses (`render_template_string(XXX_HTML...)`), then find the correct `<head>`, `<style>`, `<script>` sections within that specific template.
