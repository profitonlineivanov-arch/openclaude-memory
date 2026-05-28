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

**Why:** Пользователь работал с двумя экземплярами Claude на одной машине. Сервер 45.146.164.144 — общий контекст. Память другого экземпляла была мигрирована в текущий (2026-05-29).

**How to apply:** Если пользователь упоминает работу "брата" или настройки из System32 — это тот экземпляр. Память уже перенесена, дублировать не нужно.
