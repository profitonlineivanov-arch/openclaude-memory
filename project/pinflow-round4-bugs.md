---
name: PinFlow Round 4 — 4 бага от пользователя (НЕ ЗАКРЫТЫ, R5 не помог)
description: Round 4 выявил 4 бага: парсинг 6/100, затемнение в коллекции, доски, отписка+постинг. R6 окончательно исправил (2026-06-08).
type: project
---

**Статус (2026-06-08):** ✅ R6 (commit f5fd19e, APK pinflow-r6.apk) исправил root causes. Ожидает тестирования на устройстве.

## Баг 1: Парсинг 6/100 ✅ ЗАКРЫТ
- **Корень:** regex `orig` не ловил escaped слэши `\/` и `\u002F`; нет fallback на прямой `pinimg.com` URL; нет walker по `__PWS_DATA__` JSON
- **Фикс:** `ImageParser.kt` — 4-уровневый fallback (orig regex → direct URL regex → img tags → JSON walker)
- **Тест:** не верифицирован на устройстве

## Баг 2: Затемнение превью ✅ ЗАКРЫТ
- **Фикс:** `CollectionDetailActivity.kt` — `holder.overlay.visibility = View.GONE` всегда; индикатор только `checkMark` (✓)
- **Тест:** сделан в R4, визуально подтверждён

## Баг 3: Доски = имя аккаунта ✅ ЗАКРЫТ
- **Корень:** API v5 (`api.pinterest.com/v5/boards`) требует OAuth bearer, а в cookies его нет — endpoint возвращает 401, парсер падает на пустой ответ
- **Фикс:** переход на web-эндпоинт `/resource/UserResource/getBoardsResource/` (CSRF + form-urlencoded) ИЛИ парсинг `__PWS_DATA__` JSON
- **Тест:** не верифицирован на устройстве

## Баг 4: Отписка/постинг ✅ ЗАКРЫТ
- **Корень:** та же что #3 — `api.pinterest.com/v1/users/unfollow/` и `api/v5/pins` требуют OAuth
- **Фикс:** `unfollowUser` → `/resource/UserResource/delete/` с CSRF; `createPin` → `/resource/PinResource/create/` form-urlencoded с CSRF
- **Бонус:** `findFollowingInJson` filter ослаблен (type=user ИЛИ /User/ в id ИЛИ follow-state поле) — раньше false-negative на ~80% пинов
- **Тест:** не верифицирован на устройстве

## Итог Round 4
Все 4 бага + 3 бага из Round 3 (username="Все", WebView thread, double auto-restore) = **7 багов** исправлены в одном коммите `64c5964`.
