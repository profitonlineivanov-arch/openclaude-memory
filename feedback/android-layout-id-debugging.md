---
name: Android layout-to-code ID mismatch debugging
description: When Android build fails, cross-reference layout XML IDs with Kotlin findViewById calls — missing IDs cause compilation failure
type: feedback
---

При падении Android-билда (особенно после добавления новых Activity/Fragment) — проверить кросс-референс между ID в layout XML и вызовами `findViewById()` в Kotlin-коде.

**Why:** 2026-06-06 — GitHub Actions билд PinFlow падал несколько раз. Причина: `CollectionDetailActivity.kt` ссылалась на 9 ID (`toolbarTitle`, `infoCount`, `emptyText`, `infoKeyword`, `imagesGrid`, `fabParse`, `progressBar`, `selectionBar`, `selectionCount`, `deleteSelectedButton`), которых не было в `activity_collection_detail.xml`. Android gradle plugin генерирует R.java только из объявленных в XML `@+id/`, отсутствующие ID → «Unresolved reference» ошибка компиляции.

**How to apply:** При отладке билда — Grep по Kotlin-файлу на `R.id.xxx`, затем проверить существование каждого ID в соответствующем layout. Если ID нет в этом layout, но есть в другом — компиляция пройдёт, но будет runtime NPE. Если ID нет нигде — ошибка компиляции.
