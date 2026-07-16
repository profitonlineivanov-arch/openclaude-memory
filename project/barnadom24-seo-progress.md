---
name: Barnadom24.ru SEO Progress
description: SEO project for barnadom24.ru (alcohol delivery Moscow). Week 1 done: title, schema, robots.txt. Remaining: meta desc, caching, Search Console.
type: project
---

Barnadom24.ru — SEO project for alcohol/tobacco/vape delivery (Москва, 24/7).

**Contract:** 55,000 RUB/month, 4 stages × 13,750 RUB (Kwork).

**Why:** Niche is alcohol — ads banned in Russia, SEO is the only channel. Competitors do no SEO.

**How to apply:** Work via WP admin (admin/Armen1976/). Guard-VC blocks regular User-Agents but theme editor + post editor work. Yoast meta (title/desc) NOT settable via REST API — stored in wp_yoast_indexable, not post meta. Use functions.php via theme-editor.php for PHP changes.

## Access (updated 16.07.2026)

- **WordPress:** admin / Armen1976/
- **Sprinthost:** bar-nadom@yandex.com / Armen1976@
- **Fornex VPS:** Barnadom777@gmail.com / Armen1976/ (SPA, needs browser)
- **Google:** Barnadom777@gmail.com / 55555Hhhhh..,,3
- **Яндекс:** Jddkkddjdjdk@yandex.ru / 55555Hhhhh..,,

## Week 1 Progress (July 2026)

| Task | Status | Notes |
|------|--------|-------|
| Title главной | ✅ | "Доставка алкоголя и сигарет на дом - Бар на Дом" via REST API |
| Site name/description | ✅ | "Бар на Дом" / "Круглосуточная доставка алкоголя..." via settings API |
| Yoast site representation | ✅ | Company "Бар на Дом" via /yoast/v1/configuration/ |
| Product schema | ✅ | functions.php: price, availability, brand, rating |
| LocalBusiness schema | ✅ | functions.php: Москва, 24/7, geo 50km |
| robots.txt | ✅ | functions.php filter: Yandex/Googlebot rules + Sitemap |
| Meta description | ❌ | Need wpseo_metadesc filter in functions.php |
| Кеширование | ❌ | Can add Cache-Control + gzip in functions.php |
| Search Console | ❌ | Need verification code from google.com/search-console (login provided) |

## Next session priorities

1. Meta description via `wpseo_metadesc` filter in functions.php
2. Caching headers (Cache-Control + gzip) in functions.php
3. Google Search Console — get verification meta tag and add to wp_head

## Report file

`D:\Projects\kworks\Kwork orders\Barnadom24.ru\Отчет_Неделя1.md` — client-facing report with before/after details.
