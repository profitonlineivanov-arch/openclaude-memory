---
name: PinFlow Instant Cycle Bug
description: Автоматизация завершает цикл мгновенно (~2с, 0 задач) — подтверждено в 2 логах + root cause
type: project
---

**Обнаружено:** 2026-06-08 (лог 2026-06-05), подтверждено 2026-06-11 (лог 2026-06-11 07:39)
**Статус:** ЧАСТИЧНО ИСПРАВЛЕН (2/3). Баги 1+2 исправлены в b6af9cd + bd23861. Баг 3 (COLLECTION/ImageParser) остаётся.

**Симптом:** После запуска автоматизации цикл завершается за ~2 секунды с 0 выполненными задачами:
```
13:41:37.935  Запуск автоматизации
13:41:38.012  Автоматизация запущена для PinterestUser
13:41:40.606  Выполнение задач...
13:41:40.612  Цикл завершён
```

**Корневая причина — 3 разных бага:**

### Баг 1: GALLERY source — content:// URI не конвертится в file path — **FIXED b6af9cd+bd23861 (2026-06-11)**
- `PostSettingsActivity.addImageFromGallery()` сохраняла `uri.toString()` — `content://media/...`
- `PinterestAutomator.getPostImages()`: `File(source.value).exists()` → всегда false
- **Фикс:** заменён на folder picker + копирование content URI в `filesDir/gallery_images/` через ContentResolver
- **Commit:** b6af9cd (folder picker), bd23861 (missing FileLogger import fix)
- **APK:** `/sdcard/Download/pinflow-folder-picker.apk`

### Баг 2: ImageDownloader — молча глотает ошибки — **FIXED b6af9cd (2026-06-11)**
- `ImageDownloader.downloadImage()` — ни одного лога (строка 51: `catch (e: Exception) { null }`)
- Любой сбой (HTTP 404, таймаут, disk full) — возвращает null без следа
- **Фикс:** добавлены логи в ImageDownloader (start, HTTP fail, zero bytes, success, exception)

### Баг 3: COLLECTION — ImageParser не всегда скачивает — **НЕ ИСПРАВЛЕН**
- `ImageParser` находит URL (regex), но не видно логов вызова `downloadImage`
- В логе 2026-06-11: 80 URL найдены, 0 скачаны, `exhausted=true`, `nextBookmark=null`
- bookmarks могут быть null с первой страницы — парсер считает источник исчерпанным

**Лог 2026-06-11:**
- Auth работает (Soulexpert), CSRF токен есть
- Загружено 47 досок
- ImageParser page=1: 80 URL, exhausted=true, bookmark=null
- Автоматор: "Task complete: false - Нет изображений"

**Статус:** ЧАСТИЧНО ИСПРАВЛЕН — Баг 3 (COLLECTION/ImageParser) подтверждён в логе 2026-06-11.

**Why:** Два независимых лога с разными APK показывают одинаковый симптом. Auth работает, доски грузятся, но изображения не доходят до постинга.

**How to apply:** При фиксах — менять в 3 местах: (1) PostSettingsActivity — GALLERY URI→file, (2) ImageDownloader — добавить логи, (3) ImageParser — проверить bookmark логику. И удалить URL source из enum.