---
name: PinFlow Unfollow v7 Test
description: POST с bookmarks=[""] и field_set_key="following"
type: project
---

**Дата:** 2026-06-18 10:53

**v7 изменения:**
- Вернулся к POST запросу (GET не работал)
- `bookmarks: [""]` (массив с пустой строкой) для первой страницы
- `field_set_key: "following"` вместо `"dropdown"`
- Добавлен `Content-Type: application/x-www-form-urlencoded`

**APK:** /sdcard/Download/pinflow-unfollow-v7.apk (8.8 MB)

**Ожидание:** FollowingResource должен вернуть JSON со списком following пользователей с pagination через bookmarks token.

**Статус:** Ожидает теста