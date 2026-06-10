---
name: PinFlow Board Loader + Auth Sync
description: Auth + board loading both working (2026-06-10). Bookmarks param fix in BoardResource API, commit 71f5784
type: project
---

Auth hints и загрузка досок РАБОТАЮТ (2026-06-10).

**Board loading fix:** Pinterest API `BoardResource/get/` требует `bookmarks: ""` в options. Без него — 400 error. Добавлено в `PostSettingsActivity.kt:183`, commit `71f5784`.

**Why:** Репозитории разошлись от `7961aeb`. Синхронизация через GitHub завершена (commit `a259302`), затем board fix (`71f5784`).

**How to apply:** При изменениях PinFlow — `git fetch origin` + `git merge`. GitHub — source of truth.

**Методы загрузки досок (PostSettingsActivity.kt:135-306):**
1. API: `POST /resource/BoardResource/get/` + CSRF + `bookmarks: ""` → `board_id` + `name`
2. HTML fallback: `__PWS_DATA__` JSON parsing (МОЖЕТ НЕ РАБОТАТЬ — структура изменилась)
3. Regex fallback по board links

**Known issues:**
- Dirty build на сервере: `gradlew clean` перед `assembleDebug`
- HTML fallback (метод 2+3) не находит доски — Pinterest изменил `__PWS_DATA__` JSON
