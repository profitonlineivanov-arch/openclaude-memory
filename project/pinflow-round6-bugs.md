---
name: PinFlow Round 6 — root cause analysis
description: Detailed root causes for 5 R6 bugs — FIXED in commit f5fd19e, APK pinflow-r6.apk (2026-06-08)
type: project
---

**Дата:** 2026-06-08
**Статус:** ✅ ИСПРАВЛЕНЫ — commit f5fd19e, APK pinflow-r6.apk (8.8 MB)

## 5 багов + root causes

### 1. Парсинг: 115 при лимите 100, дубли (26 после удаления)
- **Root cause:** нет unique DB constraint на `(collectionId, sourceUrl)` + нет URL normalization (один пин в разных размерах = разные URL)
- **Фикс:** уникальный индекс в Room + `normalizeImageUrl()` (вырезает `/236x/`, `/564x/` → `/originals/`)

### 2. Коллекция: "Выбрать для удаления"
- **Root cause:** UX текст кнопки
- **Фикс:** замена на "Выбрать" (2 места в `CollectionDetailActivity.kt`)

### 3. Настройка постинга: доски не загружаются
- **Root cause:** HTML парсинг `__PWS_DATA__` (SPA не отдаёт) + board_id vs board_name mismatch
- **Фикс:** Pinterest web resource API `/resource/BoardResource/get/` с CSRF → возвращает реальные board IDs. Выпадающий `AlertDialog` вместо текстового ввода. `saveSettings()` парсит формат "id:name".

### 4a. Отписка не работает
- **Root cause:** неверный endpoint (`UserResource/delete/` = удаление аккаунта) + JSON как form-urlencoded
- **Фикс:** endpoint → `UserFollowResource/delete/`, content-type → `application/json`

### 4b. Постинг не работает
- **Root cause:** `board_id` = имя доски (нужен числовой ID) + `source_url` = локальный путь
- **Фикс:** парсинг "id:name" формата для board_id, `image_url` для внешних URL

### 5. Авторизация: никнейм = "PinterestUser"
- **Root cause:** все 4 метода extraction зависят от `__PWS_DATA__` / HTML, Pinterest SPA не отдаёт данные серверно
- **Фикс:** добавлен 5-й метод — API-вызов `/resource/UserResource/get/session/` с cookies

### 6. (bonus) Автоматизация: мгновенное завершение цикла
- Лог 2026-06-05: цикл завершается за ~2 секунды, 0 задач
- **Root cause:** задачи не настроены / парсер возвращает пустой список (связано с багами 3-4)
- Не отдельный фикс — должен исчезнуть после исправления 3-4

## Сборка
- Commit: `f5fd19e` (9 files changed, +829/-61)
- APK: `/root/pinflow_scp/pinflow/pinflow-r6.apk` (8.8 MB)
- Билд: первый прогон упал (`cookies` reference error в AuthActivity), исправлен через sed, второй BUILD SUCCESSFUL
- Backup оригинальных файлов: `/root/pinflow_backup_r6/`
