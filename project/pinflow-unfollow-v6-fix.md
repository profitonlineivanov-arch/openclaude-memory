---
name: PinFlow Unfollow v6 Fix
description: FollowingResource POST→GET с field_set_key параметром
type: project
---

**Дата:** 2026-06-18

**Проблема:** FollowingResource POST endpoint возвращает HTML вместо JSON.

**Решение v6:**
1. POST → GET запрос
2. URL: `/resource/FollowingResource/` → `/resource/FollowingResource/get/`
3. Добавить `field_set_key: "dropdown"` в data JSON
4. Запрос через query params, не form body

**Формат запроса:**
```
GET /resource/FollowingResource/get/?source_url=/{username}/following/&data={"username":"{username}","bookmarks":[""],"field_set_key":"dropdown"}
```

**APK:** v6 будет в /sdcard/Download/pinflow-unfollow-v6.apk