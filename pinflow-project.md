---
name: pinflow-project
description: PinFlow — Android Pinterest automator. Build via GitHub Actions (AAPT2 fails in Termux). GitHub repo + local clone.
type: project
---

PinFlow — Android Pinterest automator (Kotlin, Room DB, WorkManager, OkHttp3, Jsoup).

## Репозиторий
- **GitHub**: https://github.com/profitonlineivanov-arch/pinflow (private, SSH key auth)
- **Local clone**: ~/pinflow/ (на телефоне Termux)
- **Старый путь**: E:/sites/apps/PinFlow/ (Windows, устарел)

## Функциональность
Автопостинг, автолайки, автоподписки, автоотписки, расписание, spintax, WebView-based auth, foreground service, boot receiver.

## Сборка APK
- **AAPT2 не работает в Termux** — бинарник собран для glibc, Termux использует Bionic. Нативная сборка невозможна.
- **JDK 17 + Android SDK (API 34)** установлены в Termux, но не могут использоваться для финальной сборки.
- **GitHub Actions workflow**: `.github/workflows/build.yml` — собирает debug APK при ручном запуске (workflow_dispatch). Запушено в master.
- **Actions page 404**: репозиторий приватный — нужно быть залогиненым в GitHub в браузере, иначе Actions не виден.
- **proot-distro + Ubuntu** установлены в Termux, но Android SDK tools (sdkmanager, AAPT2) — бинарники x86_64, а proot на телефоне работает в aarch64. Сборка через proot тоже невозможна.
- **Удалённый сервер** 45.146.164.144 недоступен (SSH timeout, 2026-06-02) — не вариант для сборки.
- **Нет gh CLI** на телефоне, API-токен не настроен.
- **AIDE (Android IDE)** — вариант для сборки APK прямо на телефоне через GUI (не опробован).

## Статус
2026-06-02: Клонирован из GitHub, создан CI workflow, запушен в master. Попытка сборки через proot-distro ubuntu — сессия упала (краш).

2026-06-05 (сессия 1): Сессия восстановлена. APK собран через GitHub Actions, установлен на телефон. Обнаружены баги:

**Баг 1 — авторизация (2 раунда исправлений):**
- Раунд 1: `isLoggedIn()` требовал `csrftoken` (ставится до логина) → авто-сохранение до ввода пароля. Исправлено: требовать `_pinterest_sess`.
- Раунд 2: `_pinterest_sess` ТОЖЕ ставится Pinterest на странице `/login/` до ввода пароля. Добавлена проверка URL: кука есть И не на `/login/` странице.
- Периодическая проверка теперь только включает кнопку «Подтвердить», не сохраняет авто-сессию.
- `extractUsernameFromPage()` улучшен: `__INITIAL_STATE__` в приоритете, больше селекторов, URL-fallback.
- Правки закоммичены в 2 коммита (779d558, bf9d730).

**Баг 2 — автоматизация (bf9d730):**
- `startAutomation()` использовал DB-аккаунт с `autoLike=false` (дефолт) и игнорировал положения переключателей → цикл завершался мгновенно без действий.
- Исправлено: настройки свитчей применяются ПОВЕРХ DB-аккаунта. `saveSettings()` пишет в Room DB.
- Для автолайков ОБЯЗАТЕЛЬНО нужны ключевые слова (`targetKeywords`) — без них `executeLikeTask()` возвращает «Ключевые слова не указаны».

**Сборка:** GitHub Actions `.github/workflows/build.yml` (workflow_dispatch). Запуск вручную через браузер — нет `gh` CLI и токена на телефоне.

2026-06-05 (сессия 2): Пользователь пересобрал APK через GitHub Actions, установил и запустил автоматизацию. Хочет проверить логи, но не может их найти/открыть.

**Баг 3 — недоступность логов (5788e36):**
- Лог сохранялся во внутреннюю память приложения (`context.filesDir/pinflow_log.txt`) — недоступен без root/ADB.
- `shareLogFile()` пытался поделиться через FileProvider + Intent.ACTION_SEND — системное меню непонятное, файл не найти.
- Исправлено: `FileLogger.exportToDownloads()` — сохраняет копию лога в папку Downloads через MediaStore (API 29+) или напрямую (API <29). Имя файла с временной меткой: `pinflow_log_20260605_143022.txt`.
- Toast показывает путь: «Лог сохранён: Downloads/pinflow_log_...»
- При ошибке — fallback на копирование в буфер обмена.
- Пользователь может открыть файл через любой текстовый редактор ИЛИ в Termux: `cat ~/storage/downloads/pinflow_log_*.txt`.

**Pinterest auth caveat:** `_pinterest_sess` cookie устанавливается сервером Pinterest даже на странице `/login/` до ввода логина/пароля. Нельзя полагаться только на наличие куки — нужна проверка URL.

**Why:** Пользователь хочет установить приложение на телефон. Не разбирается в Linux/Termux internals, предпочитает простые GUI-решения.
**How to apply:** Предлагать GUI-варианты (AIDE, Actions в браузере) вместо CLI-подходов. Избегать сложных терминов. Для сборки — только GitHub Actions. После фиксов — напоминать про запуск Actions в браузере. Логи теперь в Downloads — пользователь может открыть файловым менеджером или через Termux (`cat ~/storage/downloads/pinflow_log_*.txt`).

2026-06-05 (сессия 3): Добавлена система коллекций изображений (commit afccb84, 26 файлов, +1323 строк).

**Функциональность:**
- **ImageCollection + CollectedImage** — новые Room-сущности (БД v2, destructive migration)
- **ImageParser** — поиск картинок Pinterest по ключевому слову через regex-парсинг JSON (паттерн `"orig":{"url":"..."}`) / fallback на `<img>` теги Jsoup, дедупликация по sourceUrl, загрузка через OkHttp
- **CollectionListActivity** — список коллекций, создание (AlertDialog), кнопка «Парсить» с прогресс-диалогом
- **CollectionDetailActivity** — грид миниатюр (Coil 2.6.0, GridLayoutManager 3 колонки), long-tap → режим выбора → удаление, кнопка «Парсить ещё»
- **Хранение**: `context.filesDir/collections/{name}/` — внутренняя память, не требует разрешений
- **Интеграция с автопостингом**: новый тип `ImageSourceType.COLLECTION`, кнопка «Из коллекции» в PostSettings, чекбокс «Удалять использованные», `markImageUsed()` в PinterestAutomator
- **Логи в Downloads** (commit 5788e36): `FileLogger.exportToDownloads()` через MediaStore

**Статус:** Код запушен в master (afccb84 — основная фича, bb8080e — удаление дубликатов). Ожидает пересборки APK через GitHub Actions для тестирования.

2026-06-05 (сессия 3, продолжение): Верификация выявила критические ошибки — дубликаты свойств в PostSettingsActivity, дубликаты ID в лейауте, неверные методы DAO/парсера в CollectionDetailActivity, отсутствие файлов лейаутов. Причина: параллельные правки агентов создали merge-артефакты. Исправлено в d93365a (PostSettingsActivity, activity_post_settings.xml, CollectionDetailActivity полностью переписан).

**Новые компоненты (пакеты):** data/ImageCollection.kt (сущности + DAO), automator/ImageParser.kt, ui/CollectionListActivity.kt, ui/CollectionDetailActivity.kt, 7 новых layout-файлов, Coil 2.6.0 в зависимостях.

2026-06-06 (сессия 4): Сессия упала, восстановлена. Две задачи:

**Фикс билда — несовпадение ID layout ↔ код (ed2f258):**
- GitHub Actions билд падал несколько раз — причина: 9 ID в `CollectionDetailActivity.kt` не существовали в `activity_collection_detail.xml` (toolbarTitle, infoCount, emptyText, infoKeyword, imagesGrid, fabParse, progressBar, selectionBar, selectionCount, deleteSelectedButton)
- ID не генерируются в R.java если не объявлены в XML → ошибка компиляции Kotlin
- Исправлено: полная переработка лейаута — добавлены все отсутствующие view, ProgressBar, selectionBar с кнопкой удаления, два FAB (parse справа, delete слева чтобы не накладывались)

**Персистентность настроек и состояния автоматизации:**
- `SessionManager`: добавлен `autoUnfollow` в `saveSettings()`/`getAutoUnfollow()`, методы `saveAutomationRunning()`/`getAutomationRunning()`
- `MainActivity.loadSettings()`: восстановление `autoUnfollow` (ранее не загружался)
- `startAutomation()`: сохранение `automationRunning = true`
- `stopAutomation()`: сохранение `automationRunning = false`
- `loadAccount()`: авто-восстановление автоматизации если флаг `automationRunning` был true (через `startButton.post { startAutomation() }`)
- Теперь после убийства приложения Android-ом настройки и автоматизация восстанавливаются без ручного вмешательства

**Статус:** ed2f258 запушен в master, GitHub Actions авто-запустит сборку (триггер: push).
