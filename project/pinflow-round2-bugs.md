---
name: PinFlow Round 2 Bugs — RESOLVED (2026-06-08)
description: 4 категории багов + username extraction + ImageParser fixes в коммитах 47f3324..b1ec51e, APK pinflow-1030.apk
type: project
---

**Статус: PARTIALLY FIXED (2026-06-08).** Баги из Round 2 исправлены, но тестирование APK `pinflow-1030.apk` выявило 3 новых бага (см. [Round 3](project/pinflow-round3-bugs.md)): username="Все", краш extractUsernameViaHttp, двойной запуск автоматора.

Исправления:
- Парсинг: рекурсивный findBookmark + throttling превью + ImageParser escape/nullable fixes
- Коллекции: сетка 2/3/4, сброс UI, FAB, navigationIconTint, dedup loadJob
- Постинг: loadUserBoards реализован, defaultBoardInput удалён
- Автоматизация: guard от двойного запуска, HTML-парсинг following + SharedPreferences
- Username extraction: URL-decode cookies + __PWS_DATA__ + HTTP OkHttp fallback (3-layer)
- Краш RecyclerView: load on IO, notify via post

Коммиты: `47f3324` → `280beec` → `487714a` → `b1ec51e`
