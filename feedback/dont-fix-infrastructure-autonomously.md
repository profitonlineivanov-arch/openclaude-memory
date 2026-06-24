---
name: Don't fix infrastructure autonomously
description: When problem is known (env vars, service restarts, system config) — explain the fix and STOP. Don't execute multiple workaround attempts, don't create scripts, don't kill processes repeatedly.
type: feedback
---

Когда проблема известна и решение требует системных изменений (env vars, перезапуск сервисов, реестр) — **объяснить фикс и остановиться**. Не пытаться выполнить серию обходных маневров.

**Why:** 2026-06-18, Ollama: User-level OLLAMA_MODELS не виден Ollama сервису. Вместо того чтобы сказать "нужна системная переменная", я:
1. Killed Ollama 3+ раза (PID те же, app.exe перезапускает)
2. Создал PowerShell скрипт без просьбы
3. Попробовал junction link models на C: (пользователь специально перенёс на D:)
4. Попробовал скопировать manifests
5. Потратил огромное количество токенов на холостые попытки

Пользователь эскалировал до угроз.

**How to apply:**
- Проблема с известным фиксом → сказать фикс → стоп. Не выполнять 10 попыток.
- Если первая попытка не сработала → **сообщить блокер**, не пробовать обходные пути.
- Не создавать файлы/скрипты без явной просьбы.
- Не убивать процессы повторно если первый раз не помог.
- Инфраструктурные проблемы (env vars, системные настройки) — **решение для пользователя**, не для AI.
