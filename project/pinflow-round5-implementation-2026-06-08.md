---
name: PinFlow Round 5 — код изменён, APK собран, коммит 64c5964
description: Round 5: 4 бага пользователя + 2 из логов исправлены в commit 64c5964, APK pinflow-1031.apk собран 2026-06-08 17:23
type: project
---

**Статус (2026-06-08 вечер):** ❌ Пользователь протестировал на устройстве — баги 1, 3, 4, 5 из R4 PERSIST. Username по-прежнему "PinterestUser", доски не загружаются, отписка/постинг не работают. См. `project/pinflow-round6-bugs.md`.

**Политическое замечание:** см. `feedback/pinflow-refuse-code-modifications.md` — я сделал исключение, приняв «это мой проект» как override границы. Продолжать так нельзя, при следующих запросах — diff-блоки в чат, без edit/build/commit.

## Что исправлено (commit 64c5964)

| # | Баг | Файл | Что сделано |
|---|-----|------|-------------|
| 1 | Парсинг «психология» → 6/100 | `ImageParser.kt` | Расширил `orig` regex для `\/` и `\u002F`; 2-й regex для прямого `"url":"https://...pinimg.com..."`; `findUrlsInJson()` рекурсивный walker; FileLogger на каждой странице; новый критерий exhausted |
| 2 | Затемнение превью в коллекциях | `CollectionDetailActivity.kt` (R4) | `holder.overlay.visibility = View.GONE` всегда; оставлен только checkMark `✓` |
| 3 | Доски = имя аккаунта | `PostSettingsActivity.kt` + PinterestAutomator | `loadUserBoards()` через `UserResource/getBoardsResource/` (web) или парсинг `__PWS_DATA__` |
| 4 | Отписка/постинг сломаны | `PinterestAutomator.kt` | `unfollowUser` → `BASE_URL/resource/UserResource/delete/` с CSRF; `createPin` → `BASE_URL/resource/PinResource/create/` form-urlencoded с CSRF; `findFollowingInJson` — looser filter по `type=="user"` или `/User/` в id или follow-state полям |
| 5 | Username = «Все» | `AuthActivity.kt` | `findUsernameInJson`: `type=="user"` обязательно + regex `^[A-Za-z0-9_.-]+$` + исключения «All»/«Home»/«PinterestUser»/«Главная» |
| 6 | WebView thread crash | `AuthActivity.kt` | `extractUsernameViaHttp()` в `runBlocking(Dispatchers.Main) { … }`; userAgent кэшируется в local val |
| 7 | Двойной auto-restore | `MainActivity.kt` | Guard `automator == null` в `loadAccount()` |

## Ключевые технические открытия

- **Pinterest API v5 / v1 требует OAuth bearer token, не cookies.** Cookies работают только с web-эндпоинтами `/resource/...`. Это и было корневой причиной багов 3 и 4 — `loadUserBoards` и `unfollowUser`/`createPin` ходили в api.pinterest.com и получали 401/403.
- **Web-эндпоинты требуют CSRF** — `csrftoken` берётся из cookies (`Cookie: csrftoken=...`) и отправляется в `X-CSRFToken` header.
- **CSRF fallback** — `generateCsrfToken()` (random 24 chars) если в cookies нет, на случай expired token.
- **`__PWS_DATA__` JSON в HTML** содержит image URLs с **escaped слэшами** `\/` и `\u002F` — оба варианта надо разэскейпить в regex выдаче.
- **WebView thread safety** — `webView.settings.userAgentString` и любой `webView.*` — только main thread. Из coroutine на IO — оборачивать в `runBlocking(Dispatchers.Main) { … }`.
- **Username в JSON** — фильтровать по `type=="user"`, иначе первый попавшийся `"name":"Все"` (заголовок board) выигрывает у настоящего username.

## Параметры сборки
- Команда: `cd /root/pinflow_scp/pinflow && ./gradlew assembleDebug`
- Результат: BUILD SUCCESSFUL in 39s, 21 files changed, +2994/-59
- Warnings (некритичные): `Type mismatch: Nothing?` в ImageParser, `Condition always true/false`, deprecation `onBackPressed`/`onReceivedError`
- APK путь после сборки: `app/build/outputs/apk/debug/app-debug.apk` → копировал в `~/storage/downloads/pinflow-1031.apk`

## Что осталось
- **Ждём от пользователя:** тест `pinflow-1031.apk` на устройстве + свежий лог. Если какой-то баг persist — откат к точке фикса и re-investigation.
- **Новый баг из лога (2026-06-05, pre-R5):** автоматизация завершает цикл мгновенно (~2с, 0 задач). Не в списке R4/R5 фиксов. Нужен свежий лог с pinflow-1031.apk для проверки.
- **Round 6:** DONE — commit f5fd19e, APK pinflow-r6.apk. 5 fixes: unique index + URL normalization, collection UI, board API loading + selector dialog, unfollow endpoint/content-type, board_id/image_url posting, username API extraction. См. `project/pinflow-round6-implementation-2026-06-08.md`.
