---
name: PinFlow auth nickname extraction fix history
description: 2026-06-09 nickname extraction was refixed twice; second APK pinflow-nickname-fix2.apk parses already-open profile URL paths.
type: project
---

**Статус (2026-06-09, второе исправление):** Пользователь протестировал `/sdcard/Download/pinflow-nickname-fix.apk`: авторизация проходила, но приложение писало «никнейм не найден»; подсказка «откройте профиль» была непонятна, потому что профиль уже открыт. Исправление доведено в `AuthActivity.kt`: извлечение из открытого профиля теперь берёт первый сегмент `window.location.pathname` / `Uri.pathSegments.firstOrNull()` и поддерживает URL вида `/username/...`, а текст ошибки заменён на «никнейм не найден на текущей странице. Дождитесь загрузки профиля или обновите страницу». Серверная сборка `/root/pinflow_scp/pinflow ./gradlew :app:compileDebugKotlin :app:assembleDebug` прошла `BUILD SUCCESSFUL`. Актуальный APK: `/sdcard/Download/pinflow-nickname-fix2.apk`.

**Статус (2026-06-09, первое исправление):** Пользователь сообщил: при авторизации никнейм не извлекается. Исправление применено в `AuthActivity.kt`: больше не сохранять fallback `PinterestUser`, возвращать `null` при провале, ставить `/resource/UserResource/get/session/` раньше слабых DOM/URL, валидировать username, не закрывать auth экран без ника, не восстанавливать saved session с пустым/фейковым username. Локальная сборка в Termux упала до Kotlin на старой AAPT2/glibc проблеме `Syntax error: Unterminated quoted string`; серверная проверка `/root/pinflow_scp/pinflow ./gradlew :app:compileDebugKotlin` прошла `BUILD SUCCESSFUL`. APK собран на сервере и скопирован в `/sdcard/Download/pinflow-nickname-fix.apk`, но тест пользователя показал, что этого было недостаточно.

**Как применять:** Если никнейм снова не извлекается, проверять устройство/логи, а не доверять старым “FIXED” отметкам R5/R6. Актуальная сборка для проверки — `/sdcard/Download/pinflow-nickname-fix2.apk`. После второго фикса локальный и серверный `AuthActivity.kt` были синхронизированы: SHA256 `7c7d39a81edd4ac69e2d5586b31ecff2a159a71ab42524b191b94ec3ae8c979d`; оба git status показывали файл изменённым (`M`).

**Предыдущий статус (2026-06-08 18:04):** Round 4 и Round 5 объединены в один коммит `64c5964`. APK `pinflow-1031.apk` собран и лежит в `~/storage/downloads/`. Подробности: [Round 5](project/pinflow-round5-fixes-done-2026-06-08.md). **Не протестировано на устройстве.**

## Причина проблемы
Username всегда был "PinterestUser" (fallback), потому что:
1. Кука `_pinterest_sess` — URL-encoded JSON, не plain JSON
2. `__INITIAL_STATE__.user.me` не существует на современном Pinterest
3. После логина URL = `pinterest.com/` (homepage), а не профиль
4. После открытия профиля URL может быть `/username/...`, а старый парсер ждал только `/username/` в конце URL

## Решение
1. **Cookie extraction** (`extractUsernameFromCookies`): URL-decode `_pinterest_sess`, поиск по 6 JSON полям (canonical_username, username, login_name, full_name, first_name, display_name)
2. **Page JS parsing** (`extractUsernameFromPage`): `__PWS_DATA__` deep search + множественные пути + `window.location.pathname` first segment
3. **HTTP/API fallback**: cookie-based `/resource/UserResource/get/session/` + homepage `__PWS_DATA__` parsing
4. **URL fallback** (`extractUsernameFromUrl`): `Uri.pathSegments.firstOrNull()` with validation
5. **Validation**: reject `PinterestUser`, service routes, spaces, `@`, invalid chars

## ImageParser.kt fixes (в том же историческом коммите)
- `"\/"` → `"/"` (illegal Kotlin escape)
- `url?.replace().replace()` → `url?.replace()?.replace()` (nullable chain)
- `urls.add(String?)` → `.let { urls.add(it) }` (type mismatch)

## Коммиты
- `47f3324` — 9 файлов, план 8+ исправлений
- `280beec` — улучшенный HTML-парсинг following
- `487714a` — фикс краша RecyclerView
- `b1ec51e` — username extraction (3-layer) + ImageParser fixes
