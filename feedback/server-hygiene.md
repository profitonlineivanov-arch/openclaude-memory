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
- Cron-логи (parser_v6.log, parser.log, data_integrity.log) — **обрезать** (truncate -s 0), не удалять (процесс пишет в файл по дескриптору)
- Неактивные логи — **удалять** целиком
- Определить активные: `crontab -l` и `ps aux | grep parser`
