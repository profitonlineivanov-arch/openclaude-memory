---
name: PinFlow Unfollow Session Summary 2026-06-21
description: Все попытки получить following через API провалились — Pinterest блокирует FollowingResource, нужен WebView/GraphQL
type: project
---

**Дата:** 2026-06-18, обновлён 2026-06-21

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

**followTime=0 issue (2026-06-21, обновлён 2026-06-21 session):**
- При follow: `followedUsers[user.username] = now` — теперь сохраняет по username (v3 fix, PinterestAutomator.kt)
- При unfollow: `getFollowingUsers()` возвращает HTML/403, fallback создаёт `UserDataWithFollowerStatus(id = username, username = username)` без followTime.
- **Root cause:** приложение никогда не делало follow — все подписки были до начала разработки. `followedUsers` SharedPreferences пуст.
- **Fix applied:** хранение по username вместо numeric ID (v3).
- **Осталось:** WebView/GraphQL для получения real followTime, либо safe fallback для pre-existing follows.

**Следующие шаги (обновлён 2026-06-21):**
1. **HTML state parsing** — пробуем `window.__PINTEREST_APP__` / `window.__INITIAL_STATE__` из HTML по brace-matching, extract реальный JSON для `findFollowingInJson`. Исправлено: `UserDataWithFollowerStatus` получил `followTime: Long`, `findFollowingInJson` вытягивает `followed_at`.
2. **Safe fallback** — если `followTime == 0` → skip unfollow (не трогаем pre-existing). В `executeUnfollowTask`: приоритет `user.followTime`, затем `followedUsers`, skip при 0.
3. WebView/GraphQL — отложен до проверки HTML state parsing