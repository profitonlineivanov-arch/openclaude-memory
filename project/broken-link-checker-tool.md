---
name: Broken Link Checker Tool
description: User wants a universal SEO/webmaster broken link checker based on Wikipedia scanning approach (2026-07-06)
type: project
---

User completed Wikipedia broken link scan for detector404.ru. After finishing, user said they want to build a **universal broken link checker** — option 3 from предложенных: утилита для SEO/вебмастеров, проверка битых ссылок на любом сайте.

**What user chose:** широкий спектр возможностей, не ограничиваясь Википедией.

**Why:** User saw the Wikipedia scanning approach work and wants to productize/extend it into a general-purpose tool.

**How to apply:** When user asks about implementing this, recall the methodology from the detector404 project:
- Crawl all pages on a domain
- Extract external links
- Check HTTP status codes
- Support proxy for regional checks (as done with 138.59.207.154:9963)
- Export reports (CSV/JSON)

**Key context from Wikipedia scanning (06.07.2026):**
- Stack used: curl + bash scripting + Wikipedia API
- ~130 links checked across 15 Wikipedia pages
- ~30 broken links found
- Files saved to /sdcard/Download/wikipedia_broken_links.txt and wikipedia_scan_report.txt
- Proxy 138.59.207.154:9963 (HTTP, credentials known) used to distinguish RKN-blocked from truly dead