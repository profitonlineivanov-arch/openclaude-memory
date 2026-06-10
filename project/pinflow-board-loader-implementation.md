---
name: PinFlow Board Loader Implementation
description: Загрузка досок Pinterest — фикс CSRF, логирование, APK и GitHub завершены (2026-06-10)
type: project
---

Загрузка досок Pinterest для постинга исправлена и завершена 2026-06-10.

**Why:** Пользователь пробовал загрузку досок в PinFlow, но она не работала. Цель — дать выбрать доску аккаунта Pinterest для последующего постинга.

**How to apply:** Если пользователь продолжит тестировать этот участок, ориентироваться на этот результат как на последний завершённый раунд: APK `pinflow-boards.apk` собран на сервере, выгружен в `/sdcard/Download/`, изменения запушены на GitHub commit `8bb799f`.

**Сделано:**
- Исправлен CSRF regex: было `csrfts3.` → стало `csrftoken=`.
- Добавлено логирование: username, cookies length, CSRF prefix, API response, HTML response length, `__PWS_DATA__`, regex fallback, counts/errors.
- Добавлены Toast-сообщения при пустых cookies/username.
- Исправлены Gradle-настройки: убраны invalid AAPT2 overrides, сборка на сервере снова проходит.
- Удалены старые fix-скрипты и старый APK-артефакт из репозитория.

**Методы загрузки:**
1. API: `/resource/BoardResource/get/` + CSRF → `board_id` + `name`.
2. HTML fallback: `__PWS_DATA__` JSON parsing.
3. Regex fallback по board links.

**Статус:** server build `BUILD SUCCESSFUL`; APK лежит в `/sdcard/Download/pinflow-boards.apk`; GitHub `profitonlineivanov-arch/pinflow` обновлён commit `8bb799f`.
