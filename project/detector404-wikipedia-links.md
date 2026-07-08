---
name: Detector404 Wikipedia Broken Links
description: Task — найти битые внешние ссылки на русской Википедии для замены на detector404.ru (2026-07-05)
type: project
---

User wants to find broken external links on Russian Wikipedia (ru.wikipedia.org) that could be replaced with links to detector404.ru.

detector404.ru — российский аналог DownDetector. Отслеживает сбои сайтов/приложений в реальном времени по регионам РФ. Фичи: аналитика, TLS-мониторинг, geoIP, блэк/вайтлисты, блог.

**Задача:** найти тематические битые ссылки в Википедии, относящиеся к downtimes/outages/monitoring, и заменить на detector404.ru.

**Why:** User wants to promote detector404.ru by fixing dead external links on Wikipedia, similar to how DownDetector is referenced in outage-related articles.

**How to apply:** When user brings up detector404.ru or Wikipedia link replacement, recall this task context — relevant Wikipedia categories include downtimes, service outages, website monitoring, интернет-цензура, доступность сайтов.

## Ключевые слова для поиска статей

| Тема | Почему может быть битая ссылка |
|---|---|
| DownDetector | прямая замена — русскоязычный аналог |
| Сбой / Отказ (информатика) | статьи о сбоях IT-систем |
| Блокировка сайтов в России | реестры, мониторинг доступности |
| Интернет-цензура в России | запрещённые сайты, доступность |
| Суверенный интернет / ТСПУ | технические средства блокировок |
| Единый реестр запрещённых сайтов | списки ресурсов |
| DDoS-атака | упоминания downtime |
| Сбой Рунета | тестирование отключений |
| Сбои Telegram / YouTube / ВКонтакте | статьи о конкретных сервисах |
| Доступность сайта / Аптайм | мониторинг |
| Мониторинг (интернет) | инструменты проверки |
| Закон о блогерах / Закон о новостных агрегаторах | регулирование контента |

## Status (2026-07-05) — завершено, подтверждено пользователем 06.07.2026

Scan performed. HTTP status checked for ~130 external links from 9+ Wikipedia pages через внешний HTTP-прокси (отличаем заблокированные РКН от реально мёртвых).

Результаты сохранены в двух файлах:
- `/sdcard/Download/wikipedia_broken_links.txt` (110 строк) — полный список битых ссылок по страницам
- `/sdcard/Download/wikipedia_scan_report.txt` (69 строк) — сводный отчёт с таблицей и рекомендациями по замене на detector404.ru

User has a proxy available (138.59.207.154:9963 HTTP, credentials отдельно). При проверке сайтов из РФ: сначала прямой запрос (таймаут = блокировка РКН ИЛИ смерть), затем через внешний прокси — если alive → заблокирован, если DEAD → действительно мёртв.

**Why:** Без прокси невозможно отличить сайты, заблокированные РКН, от реально мёртвых — все отдают timeout из РФ.

**How to apply:** При проверке доступности сайтов из РФ использовать внешний HTTP-прокси (пользователь предоставляет). User email: admin@soulexpert.ru.

### Проверенные страницы и результаты

| Статья | Links | Статус |
|---|---|---|
| DownDetector (ru) | 0 ext links | пусто |
| Интернет-цензура в России | ~50 | все живые (новостные) |
| Роскомнадзор | ~50 | все живые (официальные) |
| Список заблокированных в России СМИ | ~200 | 17 битых см. ниже |
| Роскомсвобода | ~60 | 1 битая (x. поддомен) |
| Единый реестр запрещённых сайтов | ~30 | 5 битых |
| Отключения интернета в России | ~40 | 1 битая (dept.one) |
| Закон о суверенном интернете | ~40 | все живые |
| Блокировка Telegram в России (2026) | ~25 | все живые |
| Блокировка YouTube в России | ~40 | все живые |
| Белые списки сайтов в России | ~20 | все живые |
| Технические средства противодействия угрозам | ~30 | все живые |
| Рунет | ~30 | 3 битых |
| DoS-атака | ~20 | 1 битая (archive.org 404) |
| Killnet | ~20 | 6 битых |
| WhatsApp | ~20 | 1 битая (siliconrus.com 502) |

### Проверка через прокси вне РФ (138.59.207.154:9963, HTTP)

Из ~65 сайтов, отдававших timeout из РФ, проверка через внешний прокси показала:

**Реально мертвы (DEAD / timeout отовсюду) — из списка заблокированных СМИ:**
- `lentachel.ru` — timeout
- `republic.ru` — DNS не резолвится
- `metla.press` — timeout
- `opposition-news.com` — timeout
- `rezonans.media` — timeout
- `vesma.today` — timeout
- `antiwar.in` — timeout
- `kolsar.org` — timeout
- `fn-volga.ru` — timeout
- `reestr.rublacklist.net/record/4118710/` — timeout (запись битая)

**ERR 502/404/403 (сайт есть, страница битая) — из списка заблокированных СМИ:**
- `kasparov.ru` — 502 Bad Gateway
- `sputnikipogrom.com` — 502 Bad Gateway
- `zasekin.ru` — 502 Bad Gateway
- `semnasem.org` — 404 Not Found
- `root-nation.com` — 403 Forbidden
- `tvfreedom.io` — 403 Forbidden

**Битые из старых ссылок (Runet + Реестр):**
- `asozd2.duma.gov.ru/main.nsf/...` — DEAD (старая система)
- `asozd2c.duma.gov.ru/main.nsf/...` — DEAD (вторая ссылка)
- `10ru.ru/rulet/laureate/` — 404 Not Found
- `forum.yandex.ru/yandex/quest-arch.xhtml` — 404 Not Found
- `premiaruneta.ru/about/rules/` — 502 Bad Gateway
- `computerra.ru/45098/` — 500 Internal Server Error
- `rsoc.ru/news/rsoc/news17172.htm` — 403 Forbidden

**Битые из «Интернет-цензура в России»:**
- `jourdom.ru/news/110640` — DEAD
- `tvzvezda.ru/news/vstrane_i_mire/content/201707211813-x1mz.htm` — 404
- `constitution.kremlin.ru/` — DEAD (старая ссылка на конституцию)

**Битые из «Закон о суверенном интернете»:**
- `hi-tech.mail.ru/news/skolko-stoit-blokirovka-interneta/` — 404

**Битые из «DoS-атака»:**
- `archive.org/details/isbn_5845907330` — 404 (сам archive.org жив, страница не найдена)

**Живы снаружи, заблокированы в РФ (не подходят):**
~35 сайтов — все живы, только недоступны из РФ. Полный список в `/sdcard/Download/wikipedia_broken_links.txt`.