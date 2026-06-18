---
name: PinFlow Unfollow v8 Result
description: CSRF найден (32 chars), но FollowingResource отдаёт HTML вместо JSON
type: project
---

**Дата:** 2026-06-18 12:26

**v8 результат:**
- CSRF токен: found (32 chars) ✓
- FollowingResource POST → 402KB HTML (не JSON)
- following.size=13 (из HTML fallback, mock данные)
- Отписок: 0 (у всех followTime=0)

**Проблема:** Pinterest не отдаёт following через POST к /resource/FollowingResource/ — возвращает HTML страницу вместо JSON API ответа.

**Race condition:** Параллельные потоки получают разные cookies — один нашёл CSRF (32 chars), другой нет (NOT FOUND). Нужно синхронизировать доступ к cookies.

**Вывод:** FollowingResource endpoint требует GET запрос с query params, не POST с form body.

**APK:** /sdcard/Download/pinflow-unfollow-v8.apk