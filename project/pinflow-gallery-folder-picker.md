---
name: PinFlow GALLERY folder picker + URL removal
description: Заменить выбор одного изображения из галереи на выбор папки + bulk import + удалить URL source
type: project
---

**Задача:** Переделать источник GALLERY в PostSettingsActivity — вместо single image picker (GetContent) сделать folder picker (ACTION_OPEN_DOCUMENT_TREE), скопировать все найденные изображения в app storage и добавить как ImageSource.

**Дополнительно:** Удалить `ImageSourceType.URL` из enum и убрать кнопку/логику URL источника.

**Изменённые файлы (commit b6af9cd, 2026-06-11):**
1. `Account.kt` — удалён `URL` из `ImageSourceType` enum
2. `PostSettingsActivity.kt` — `GetContent()` → `ACTION_OPEN_DOCUMENT_TREE`; убрана кнопка/диалог URL; копирование файлов из content URI → `filesDir/gallery_images/` через ContentResolver; сохранение реальных file paths как ImageSource values
3. `PinterestAutomator.kt` — удалён `ImageSourceType.URL ->` блок из `getPostImages()`
4. `PinterestWorker.kt` — удалён `ImageSourceType.URL ->` блок из `collectImages()`
5. `ImageDownloader.kt` — добавлены FileLogger.log() для начала/успеха/ошибки/zero-byte скачивания
6. `app/build.gradle` — добавлена `androidx.documentfile:documentfile:1.0.1`

**Fix (commit bd23861, 2026-06-11):**
- Добавлен отсутствующий `import com.pinflow.utils.FileLogger` в ImageDownloader.kt — без него сборка падала с `Unresolved reference: FileLogger`

**Статус:** BUILD SUCCESSFUL (2026-06-11 11:31). APK: `/sdcard/Download/pinflow-folder-picker.apk` (8.3 MB). Коммиты b6af9cd и bd23861 запушены на GitHub.
