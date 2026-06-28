---
name: PinFlow boards broken 2026-06-28 — root cause CSRF + bc653fe HTML — COMMITTED + APK BUILT, AWAITING TEST
description: Boards не грузятся в PostSettingsActivity из-за CSRF cookie с ru.pinterest.com + новый appVersion bc653fe в __PWS_DATA__ ломает findBoardsFromJson. Фикс закоммичен 5be1a33 на server, APK ~/downloads/pinflow-csrf-fix.apk, НЕ протестирован.
type: project
---

# PinFlow boards loader broken — диагностика и фикс

## Симптомы (из FileLogger на устройстве, log view 28.06.2026 11:13)
- `PostSettings → Загрузить доски` → 0 досок в списке
- `Cookies length: 3522` (валидный вход с `_pinterest_sess=`), но без `csrftoken=`
- `CSRF token: ` пуст → BoardsResource → 403 "No CSRF cookie"
- HTML fallback отрабатывает: `__PWS_DATA__ found`, `HTML response length: ...`
- `Boards from __PWS_DATA__: 0` + `Boards from regex: 0` (`findBoardsFromJson` не подходит под bc653fe SPA)
- При рестарте приложения WebView куки сбрасываются — сессия выживает в SessionManager, но CSRF пропадает.

## Корневая причина (одна)
**AuthActivity** сохраняет cookies только с `getCookie("https://www.pinterest.com")`. Юзер зашёл через `https://ru.pinterest.com/login/`. CSRF куки привязан к поддомену и НЕ возвращается через getCookie от `www.pinterest.com` → API без CSRF → 403. Парсер `__PWS_DATA__` не виноват — он срабатывает после API fallback, но видит сторонний appVersion, под который нужен новый рекурсивный обход (отложен).

## Почему раньше работало (и не сломано в коде)
Юзер **раньше логинился через www.pinterest.com** (round5/6 логи: cookies=3746, успешный BoardsResource). 28.06 он зашёл через региональный редирект → cookies сохранены, но CSRF остался на `ru.pinterest.com`. Код не регрессировал — изменился user-flow.

## Состояние фикса (вечер 2026-06-28)
- **ЗАКОММИЧЕН** на server `/root/pinflow_scp/` как `5be1a33` (5 files, +101/-14)
- **APK собран** 13:42 Jun 28: `/root/pinflow_scp/app/build/outputs/apk/debug/app-debug.apk` (8.6MB)
- **Скачан в Termux**: `~/downloads/pinflow-csrf-fix.apk` (8653322 bytes)
- **НЕ доставлен на устройство**: /sdcard/Download/ недоступен без `termux-setup-storage` opt-in
- **НЕ протестирован**: ждём юзера — логин через ru.pinterest.com → «Загрузить доски» → должны появиться

## Применённый фикс 2026-06-28 (3 файла на сервере, commit 5be1a33)
1. **`app/src/main/java/com/pinflow/utils/CookieHelper.kt`** (новый, 92 строки) — singleton `CookieHelper`:
   - `collectAll()`: перебирает 5 URL (`www`, `ru`, `pinterest.com`, `pincode.ru`, `pincode.pinterest.com`) → мерджит по уникальным именам, last-wins.
   - `mergeFromWebView(sessionCookies)`: если session уже сохранён и CSRF в нём есть → вернуть session; иначе дотянуть из живого WebView через `collectAll()`. Это нужно для PostSettingsActivity, где cookies читаются из SharedPreferences (а WebView куки после рестарта могут быть пустыми).
   - `extractCsrf(cookies)`: достаёт значение csrftoken через `Regex("csrftoken=([^;\\s]+)")`.
2. **`AuthActivity.kt` строка ~470** — `getCookie("https://www.pinterest.com")` → `CookieHelper.collectAll()` в `saveSessionAndFinish`.
3. **`PostSettingsActivity.kt` строки ~145-155** — `session.getCookies()` теперь проходит через `CookieHelper.mergeFromWebView(sessionCookies)`, дополнительно логируется "Effective cookies length".

Board parser НЕ трогали (свежие логи не показали, что bc653fe даёт другой формат — нужен будет отдельный заход, когда юзер снова попадёт в HTML fallback path).

**Why:** Юзер сказал «раньше все работало» и потом — «пользователь будет открывать пинтерест так, как он открывается, т.е. в домене ru». Это значит — фикс должен работать для КАЖДОГО регионального поддомена, не только ru.

**How to apply:**
- Если юзер снова жалуется на «доски не грузятся» — спросить через какой URL он зашёл и проверить лог `PostSettings → CookieHelper → csrftoken present/MISSING`. Если MISSING — нужно расширить список доменов в `CookieHelper.domains`.
- Если API возвращает 200 но 0 досок после фикса — значит bc653fe реально сломал парсер, тогда уже чинить `findBoardsFromJson`.
- Избегать заводить новую SessionManager-логику — Retrofit через `CookieHelper` это правильный паттерн для PinFlow.
- APK (с новым CookieHelper) собирается на сервере: `cd /root/pinflow_scp && ./gradlew assembleDebug --no-daemon` → `/root/pinflow_scp/app/build/outputs/apk/debug/app-debug.apk`. Перед сборкой проверить `local.properties=sdk.dir=/opt/android-sdk`.
