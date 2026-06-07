---
name: pinflow-project
description: PinFlow — Android Pinterest automator. Build on server 45.146.164.144 (x86_64). GitHub repo + local clone.
type: project
---

PinFlow — Android Pinterest automator (Kotlin, Room DB, WorkManager, OkHttp3, Jsoup).

## Репозиторий
- **GitHub**: https://github.com/profitonlineivanov-arch/pinflow (private, SSH key auth)
- **Local clone**: ~/pinflow/ (на телефоне Termux)
- **Сборка**: на сервере 45.146.164.144 (x86_64, JDK 17, Android SDK в /opt/android-sdk)

## Функциональность
Автопостинг, автолайки, автоподписки, автоотписки, расписание, spintax, WebView-based auth, foreground service, boot receiver, коллекции изображений.

## Сборка APK
- **Termux**: AAPT2 несовместим (x86-64 бинарник на aarch64) — локальная сборка невозможна
- **Сервер 45.146.164.144**: проект в `/root/pinflow_scp/pinflow/`, SDK в /opt/android-sdk.
  При первом копировании проекта нужно создать local.properties:
  ```
  echo 'sdk.dir=/opt/android-sdk' > /root/pinflow_scp/pinflow/local.properties
  ```
  Команда сборки:
  ```
  ssh root@45.146.164.144 "cd /root/pinflow_scp/pinflow && export ANDROID_HOME=/opt/android-sdk && ./gradlew assembleDebug --no-daemon 2>&1"
  ```
- **Скачать APK**: 
  ```
  scp root@45.146.164.144:/root/pinflow_scp/pinflow/app/build/outputs/apk/debug/app-debug.apk ~/pinflow-debug.apk
  ```
- **Установка**: `termux-open ~/pinflow-debug.apk` (открывает системный установщик)
- Перед сборкой проверять место: `ssh root@45.146.164.144 "df -h /"` (нужно ~2.5 GB свободно)

## Kotlin уроки сборки
- Sealed enum `when` требует все ветки или `else`
- suspend-функции нельзя вызывать из не-suspend лямбд без `launch { }`

## История сессий

2026-06-07 (сессия 8 — тестирование, 5 багов):
Пользователь протестировал APK (сборка с сервера). Лог: `pinflow_log_20260607_091221.txt` в Downloads.

**5 багов от пользователя:**

1. **Парсинг порциями**: searchPinterest ищет только 1 страницу (~20 изображений). При maxCount=250 нужно жать «Парсить» 250+ раз. Надо: автоматически продолжать до заполнения или исчерпания результатов.

2. **Превью + выбор сетки**: нет live-обновления при парсинге, фиксированные 3 колонки. Надо: превью появляются сразу, переключатель 2/3/4 колонки, новые сверху. Баг чекбоксов: долгий тап выбирает все изображения (isSelectionMode определяется через selectedIds.isNotEmpty() вместо флага Activity).

3. **Автопостинг — доски**: не подгружаются доски из аккаунта. Непонятно зачем поле «Основная доска».

4. **Коллекция #1 без названия**: в PostSettings источник COLLECTION показывает "Коллекция #ID" вместо name из БД.

5. **Статистика**: нет unfollows в UI, нет ошибок, числа меняются (10→8→10) при возврате. Нужна развернутая статистика с «Сегодня» и «Всего».

**Состояние:** все 5 исправлений реализованы и собраны 2026-06-07:
- #1 (пагинация): searchPinterestPaginated с bookmark, цикл до maxCount или exhausted
- #2 (превью + сетка): grid toggle 2/3/4, live loadImages каждые 5 скачанных
- #3a (дубликаты): getCollectionByName() проверка перед INSERT
- #3b (чекбоксы): явный флаг isSelectionMode в адаптере вместо selectedIds.isNotEmpty()
- #4 (название коллекции): async загрузка имени из БД в renderImageSources() через scope.launch
- #5 (статистика): unfollows/errors в UI, Gson+SharedPreferences персистентность, LogManager(context), saveStats/loadStats
BUILD SUCCESSFUL, APK 8.3M скачан в ~/storage/downloads/PinFlow-debug.apk (2026-06-07).

**Исправления ошибок компиляции (2026-06-07):**
- CollectionListActivity.kt: конфликт импортов Toast (дубликат) — удалён лишний import
- PostSettingsActivity.kt: `lifecycleScope` не существует → добавлен `import androidx.lifecycle.lifecycleScope`
- PinterestAutomator.kt: `logManager` был `LogManager()` без context → исправлен на `LogManager(context)`, иначе saveStats() не работал
- MainActivity.kt: `automator?.logManager?.saveStats()` (private field) → `automator?.saveStats()` (public method added)
- Случайное копирование CollectionListActivity.kt в automator/ → удалён, пересобран
- Грязный build cache после исправления ошибок: `rm -rf app/build .gradle` (оба), иначе dex/ksp падают с NoSuchFileException

## Предыдущие сессии (кратко)
- 2026-06-02: Клонирован, CI workflow, попытка proot-сборки (краш)
- 2026-06-05 (сессия 1-3): Фиксы авторизации, автоматизации, логов. Система коллекций (afccb84).
- 2026-06-06 (сессия 4-5): Фикс ID layout↔код, персистентность настроек. GitHub Actions недоступен.
- 2026-06-07 (сессия 6-7): Успешная сборка на сервере (3 Kotlin-фикса), APK 8.6 MB, установлен через termux-open.

**Why:** Основной проект пользователя на Android. Сборка возможна только на сервере x86_64. Пользователь тестирует каждую версию на своём телефоне.
**How to apply:** Для сборки — только сервер. Для установки — termux-open. После фиксов пересобирать и давать пользователю на тестирование. Логи всегда в ~/storage/downloads/.