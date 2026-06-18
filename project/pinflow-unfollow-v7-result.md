---
name: PinFlow Unfollow v7 Result
description: CSRF cookie не найдена, FollowingResource возвращает 403 "No CSRF cookie"
type: project
---

**Дата:** 2026-06-18 11:36

**v7 тест:**
- Перелогинился, cookies обновились (3525 байт)
- FollowingResource POST → 403 "No CSRF cookie" (14 байт)
- HTML fallback нашёл 12 usernames (mock данные)
- followTime=0 для всех — не реальные данные
- Отписок: 0

**Root cause:** Pinterest требует CSRF токен в заголовке X-CSRFToken. Регулярное выражение `csrftoken=([^;]+)` не находит токен в cookies.

**Решение:** v8 добавит лог CSRF токена для отладки. Проверить имя cookie (возможно Pinterest сменил на `pinterest_csrf` или другое).

**APK:** /sdcard/Download/pinflow-unfollow-v8.apk (8.4 MB, собран 12:13)

**v8:** Добавлен лог CSRF токена — покажет "found" или "NOT FOUND" для отладки.