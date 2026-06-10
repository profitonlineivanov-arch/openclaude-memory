---
name: PinFlow Board Loader Status
description: Загрузка досок ИСПРАВЛЕНА (2026-06-10): Pinterest API требует bookmarks param, commit 71f5784
type: project
---

Загрузка досок ИСПРАВЛЕНА (2026-06-10).

**Root cause:** Pinterest API `BoardResource/get/` стал требовать параметр `bookmarks` в options (для пагинации). Без него возвращает 400: `"Required arguments are missing"`. HTML fallback (`__PWS_DATA__` + regex) тоже не находил доски — структура JSON изменилась.

**Fix:** Добавлена строка `put("bookmarks", "")` в options запроса в `PostSettingsActivity.kt:183`. Commit `71f5784`.

**Why:** API изменился на стороне Pinterest. Старый запрос без `bookmarks` перестал работать. Раньше работало без этого параметра.

**How to apply:** При проблемах с загрузкой досок — проверять что API параметры соответствуют текущему Pinterest API (может меняться без уведомления). FileLogger в PostSettingsActivity пишет полные логи в `pinflow_log.txt`.

**Синхронизация и сборка (2026-06-10):**
- Local → GitHub → Server: commit `71f5784`
- APK: `/sdcard/Download/pinflow-board-fix.apk` (8.8MB)
- Старые APK удалены: pinflow-auth-hints.apk, pinflow-sync-auth.apk
