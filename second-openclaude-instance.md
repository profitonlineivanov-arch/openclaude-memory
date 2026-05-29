---
name: second-openclaude-instance
description: Another OpenClaude instance at C:\Windows\System32\.openclaude\ — memory was in C--Windows-system32 project dir, contained "Гера" naming error (Гера = Hermes agent, not user)
type: reference
---

Второй экземпляр OpenClaude установлен в `C:\Windows\System32\.openclaude\` (запускался от администратора).

**Содержимое:** `settings.local.json` с разрешениями:
- `Bash(ssh:*)` — SSH-команды
- `WebFetch(domain:45.146.164.144)` — запросы к серверу

**Память:** хранилась в `C:\Users\admin\.openclaude\projects\C--Windows-system32\memory\` — тот же пользователь `admin`, но другой working directory → отдельный project namespace. Содержала: feedback (11 файлов), project (5), reference (3), team (5), user-vlad.md, server-credentials.md, remote-projects.md.

**Важная ошибка:** другой экземпляр записал "Гера" как предпочтительное имя пользователя. На самом деле "Гера" (Гермес/Hermes) — это имя AI-агента, а не пользователя. Пользователь — Влад. Не повторять эту ошибку.

**Мобильный агент:** У пользователя также есть OpenClaude CLI на мобильном. Работает с тем же сервером 45.146.164.144 и GitHub. Доступа к файлам этого ПК нет. Память синхронизируется через GitHub (см. `team/openclaude-memory-sync.md`).

**Why:** Пользователь работает с двумя агентами (desktop + mobile). Сервер 45.146.164.144 и GitHub — общий контекст. Память другого экземпляла была мигрирована в текущий (2026-05-29).

**How to apply:** "Брат" = мобильный агент. Если пользователь упоминает работу с мобильного — это тот же OpenClaude CLI, память синхронизирована через GitHub.
