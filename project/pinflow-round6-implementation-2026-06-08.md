---
name: PinFlow R6 — implementation details
description: R6 fixes applied via Python script on server: 5 fixes, commit f5fd19e, APK pinflow-r6.apk (2026-06-08)
type: project
---

**Дата:** 2026-06-08
**Коммит:** `f5fd19e` (9 files, +829/-61)
**APK:** `pinflow-r6.apk` (8.8 MB)
**Скрипт:** `/root/pinflow_scp/pinflow/pinflow_r6_fixes.py`
**Backup:** `/root/pinflow_backup_r6/`

## Что исправлено

| # | Файл | Изменение |
|---|------|-----------|
| 1 | `ImageCollection.kt` | Unique index на `(collectionId, sourceUrl)` |
| 1 | `AppDatabase.kt` | DB version 2→3 (fallbackToDestructiveMigration) |
| 1 | `ImageParser.kt` | `normalizeImageUrl()` companion object + `.map { normalizeImageUrl(it) }` перед filter |
| 2 | `CollectionDetailActivity.kt` | "Выбрать для удаления" → "Выбрать" (2x replace) |
| 3 | `PostSettingsActivity.kt` | `loadUserBoards()` через API `/resource/BoardResource/get/`, `BoardInfo(id, name)` data class, `showBoardSelectorDialog()`, `saveSettings()` парсит "id:name" |
| 4a | `PinterestAutomator.kt` | unfollow endpoint `UserFollowResource/delete/` + content-type `application/json` |
| 4b | `PinterestAutomator.kt` | `image_url` для http URLs, board_id парсинг из "id:name" |
| 5 | `AuthActivity.kt` | `extractUsernameViaApi()` — `/resource/UserResource/get/session/`, 5-й в цепочке fallback |

## Известные проблемы сборки
- AuthActivity: `cookies` reference error — исправлен через `sed -i` (script не учёл scope переменной)
- 18 warnings (non-critical): deprecated methods, unreachable code, type mismatches в ImageParser
