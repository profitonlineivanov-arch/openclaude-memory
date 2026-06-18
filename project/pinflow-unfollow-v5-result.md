---
name: PinFlow Unfollow v5 Result
description: HTML fallback сработал, но Pinterest не рендерит following список в HTML
type: project
---

**Дата:** 2026-06-18

**Проблема:** FollowingResource endpoint возвращает HTML вместо JSON. Pinterest сменил поведение API.

**v5 fix:** Добавлена HTML детекция перед JSON парсингом + fallback на GET /username/following/ с парсингом username из embedded JSON.

**Результат теста:**
- HTML детекция сработала ✓
- HTML fallback запустился ✓
- Alternative pattern нашёл 1 пользователя (владелец аккаунта)
- Отписок: 0 — Pinterest не рендерит список following в исходном HTML

**Root cause:** Pinterest загружает following список через JS после загрузки страницы. HTML содержит только шаблон, не данные.

**Следующий шаг:** Нужен прямой API запрос с правильными заголовками или использование bookmarks pagination parameter.

**APK:** /sdcard/Download/pinflow-unfollow-v5.apk (8.8 MB)