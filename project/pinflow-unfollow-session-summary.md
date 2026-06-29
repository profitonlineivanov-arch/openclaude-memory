---
name: PinFlow Unfollow Session Summary 2026-06-18
description: Все попытки получить following через API провалились — Pinterest блокирует FollowingResource
type: project
---

**Дата:** 2026-06-18

**Попробованные подходы (v5-v10):**

1. **POST /resource/FollowingResource/** → HTML страница (398-402KB), не JSON
2. **GET /resource/FollowingResource/get/** → 403 "Invalid Resource Request" (24 байта)
3. **GET с source_url без trailing slash** → 403
4. **HTML fallback** → Pinterest не рендерит following в initial HTML (JS подгружает)
5. **Embedded JSON в HTML** → 12 mock usernames (followTime=0), не реальные данные

**Технические детали:**
- Cookies работают (3525-3746 байт, свежие после relogin)
- CSRF токен: то найден (32 chars), то NOT FOUND (race condition в параллельных потоках)
- `/_ngjs/data/Options.json` тоже возвращает HTML
- Прямой GET на `/{username}/following/` → HTML без данных following

**Root cause:** Pinterest изменил FollowingResource API — отдаёт HTML/ошибку вместо JSON. Список following подгружается через JS (React hydration), а не через initial HTML или API.

**Race condition:** Параллельные потоки отписок и подписок получают разные cookies — один находит CSRF, другой нет.

**APK:** v10 в /sdcard/Download/pinflow-unfollow-v10.apk

**Следующие шаги:**
1. Использовать Selenium/WebView для рендеринга JS и извлечения following
2. Или использовать Pinterest GraphQL API (если есть)
3. Или попробовать другие endpoints: /resource/UserFollowingResource/, /resource/BoardFollowingResource/
