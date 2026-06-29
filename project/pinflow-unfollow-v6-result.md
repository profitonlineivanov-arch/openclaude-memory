---
name: PinFlow Unfollow v6 Result
description: GET с field_set_key вернул "Invalid Resource Request", HTML fallback нашёл 12 mock пользователей
type: project
---

**Дата:** 2026-06-18 10:33

**v6 тест:**
- FollowingResource GET с `field_set_key="dropdown"` → "Invalid Resource Request"
- HTML fallback нашёл 12 usernames в embedded JSON
- following.size=12, но followTime=0 для всех
- Отписок: 0

**Вывод:** GET endpoint не работает. HTML fallback находит mock/default данные шаблона, не реальный following.

**Следующий шаг:** Вернуться к POST запросу. Возможно Pinterest требует:
1. Правильный format bookmarks: `[""]` вместо `[]` или `"\"\""` 
2. Другой Content-Type заголовок
3. Booking pagination token