---
name: PinFlow Unfollow Session Summary 2026-06-21
description: Все попытки получить following через API провалились — Pinterest блокирует FollowingResource, нужен WebView/GraphQL. Статус на 2026-06-25: FollowingResource 100% 403.
type: project
---

**Дата:** 2026-06-18, обновлён 2026-06-25

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

**Статус на 2026-06-25:** FollowingResource ранее возвращал JSON intermittently (сессия 2026-06-12: 200 OK 408KB). Сейчас (тест pinflow-fixes.apk) 100% 403 — Pinterest полностью заблокировал API endpoint для всех версий.

**Решение от 2026-06-25:** Follow/unfollow отложены на следующий этап разработки. Код unfollow сохранён в отдельной ветке GitHub. Из текущей версии приложения функциональность unfollow удалена.

**followTime=0 issue (2026-06-25):**
- Приложение не делало follow самостоятельно — все подписки существовали до разработки
- `followedUsers` SharedPreferences пуст
- HTML embedded JSON не содержит `followed_at` ни в каком виде
- `collectFollowTimes()` не находит данных
- **Итог:** unfollow не работает, т.к. followTime=0 для всех существующих подписок

**Необходимо для фикса:**
1. WebView/GraphQL для получения списка following и followTime
2. Либо механизм unfollow без followTime (по возрасту подписки из HTML, или просто unfollow всех с задержкой)
