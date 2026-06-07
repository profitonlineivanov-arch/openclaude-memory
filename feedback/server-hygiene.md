---
name: Server hygiene preference
description: User values keeping remote server clean — remove obsolete AI tool directories, temp files, .bak files, __pycache__ regularly
type: feedback
---

Гера предпочитает чистый удалённый сервер — удалять артефакты от старых AI-инструментов, временные файлы, .bak, __pycache__.

**Why:** На сервере накапливается мусор от разных AI-инструментов (.hermes от Hermes/Claude Code, .openclaw от OpenClaw, .qwen от Qwen/Cline) и одноразовые скрипты отладки в /tmp/. Это занимает место и засоряет рабочее пространство.

**How to apply:** При работе на сервере периодически проверять и удалять:
- Артефакты AI-инструментов: `.hermes`, `.openclaw`, `.qwen` в /root/ и проектах
- `/tmp/*.py`, `/tmp/*.json`, `/tmp/*.csv`, `/tmp/*.log` — одноразовые скрипты отладки (349MB+ может накапливаться)
- `/tmp/com.google.Chrome.*`, `/tmp/org.chromium.*` — артефакты Selenium/Chrome
- `/tmp/rarity_*.{mp3,mp4,m4a}` — медиафайлы от тестов TTS/видео
- `.bak`, `.tmp` файлы в проектах
- `__pycache__` вне venv
- Старые `/root/*.log` (fill_forecasts.log, gpt2giga.log и т.д.) — удалять

**Активные vs неактивные логи:**
- Cron-логи (parser_v6.log, parser.log, data integrity.log) — **обрезать** (truncate -s 0), не удалять (процесс пишет в файл по дескриптору)
- Неактивные логи — **удалять** целиком
- Определить активные: `crontab -l` и `ps aux | grep parser`

## ЗАПРЕЩЕНО удалять без проверки процессов (проверено 2026-06-07)

- **`/opt/google/chrome/` (397 МБ)** — ИСПОЛЬЗУЕТСЯ парсерами 2x2, 1224, 4x20 через selenium. Все три парсера в cron: `cd /root/projects/X && venv/X/bin/python parser_v7.py` — стартуют каждые 15 мин и дёргают ChromeDriverManager. Без `/opt/google/chrome` selenium-парсеры упадут мгновенно. Проверять `ps aux | grep -E 'chrome|chromedriver'` и `grep -l selenium /root/projects/*/parser*.py` перед удалением.
- **`/usr/bin/chromedriver`** — первичный путь в `parser_v6.py` (2x2), fallback на ChromeDriverManager. Не удалять.
- **`/root/snap/` (40 МБ) — `snapd` РАБОТАЕТ** (PID 3172794, started Apr 23). Также `cupsd` (принт-сервер) и `cups-browsed` от snap/cups. Удаление `/root/snap` убьёт snapd и сломает snap-управляемые пакеты. `snapd` — точно нельзя. `cups` — можно, если принтер не используется, но рискованно.

**Перед удалением чего-либо в /opt, /usr/bin, /root, /etc/systemd:**
1. `ps aux | grep <name>` — есть ли активные процессы
2. `grep -rl '<name>' /root/projects/*/parser*.py` — используется ли парсерами
3. `crontab -l | grep <name>` — стартует ли по расписанию
4. Только после всех трёх проверок — удалять.
