---
name: Wikipedia Broken Links Scan
description: scanned 15 Russian Wikipedia pages for broken external links on 2026-07-06, found ~30 dead links, results on phone + desktop
type: project
---

## Wikipedia Broken Links Scan (2026-07-06)

User scanned Russian Wikipedia pages for broken external links — client order (заказчик). Goal: replace dead links with detector404.ru service references.

**Methodology**: API collection + HTTP check via proxy 138.59.207.154:9963 (to filter out RKН blocks from truly dead sites). Date: 06.07.2026.

**Pages checked**: 15
**Broken links found**: ~30

**Files**:
- `/sdcard/Download/wikipedia_broken_links.txt` — detailed broken link list per article
- `/sdcard/Download/wikipedia_scan_report.txt` — summary: table per page + recommendations
- Both pulled to `~/Desktop/` on Windows laptop

**Articles with most broken links**:
1. "Список заблокированных в России СМИ" — 17 dead/error links (republic.ru, lentachel.ru, metla.press etc. — fully dead)
2. "Killnet" — 6 dead (tylaz.net, postsen.com, zerkalo.io x3, siliconrus.com)
3. "Единый реестр запрещённых сайтов" — 5 dead (asozd2.duma.gov.ru x2, computerra.ru, rsoc.ru, 10ru.ru)

**Zero broken**: YouTube, Белые списки, ТСПУ, Отключения pages.

**Retrieved via**: ADB from laptop — smartphone connected via USB, authorized RSA key first.

**Client report**: formatted text report + **Excel report** `~/Downloads/wikipedia_links_report_2026-07-06.xlsx` — 4 sheets (Сводка, Все битые ссылки, Рекомендации, Методология). Generated via Node.js + `xlsx` package (Python openpyxl unavailable through Git Bash). Delivered to user's Downloads.

**Why**: this matters for remembering we have these scan files available for editing Wikipedia references.
