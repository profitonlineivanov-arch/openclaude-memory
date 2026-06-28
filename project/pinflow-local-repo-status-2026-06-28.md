---
name: PinFlow Local+Server Repo Status 2026-06-28
description: CSRF fix committed on server as 5be1a33 (CookieHelper+AuthActivity+PostSettingsActivity+activity_main.xml). APK built 13:42, downloaded to ~/downloads/pinflow-csrf-fix.apk, NOT delivered to device. Local master still at 18c2b94 (3 commits behind) + local-only MainActivity/XML edits.
type: project
---

# PinFlow Repository Status — 2026-06-28 (post-CSRF-commit)

## Local repo at `~/pinflow` (Termux)
- **Branch:** master, up to date with `origin/master`
- **Latest commit:** `18c2b94` — fix(auth): mark extractUsernameViaHttp as suspend
- **Устарел на 3 коммита**: нет `741f895`, `97da5f0`, `5be1a33`
- **Local-only uncommitted:** `app-debug.apk`, `app/src/main/java/com/pinflow/ui/MainActivity.kt`, `app/src/main/res/layout/activity_main.xml`
  - MainActivity.kt + activity_main.xml — local edits diverging from server; need merge decision before sync

## Server repo at `/root/pinflow_scp/` (ahead of local, clean working tree after commit)
- **Latest commits:**
  - `5be1a33` — fix(boards): collect CSRF cookie across all Pinterest domains via CookieHelper (CSRF fix, 5 files, +101/-14)
  - `97da5f0` — fix: repair broken XML/Kotlin after follow/unfollow removal
  - `741f895` — refactor: remove follow/unfollow features from master
  - `073c1e6` — fix(r7): WebView thread, CSRF stale fallback, followTime, username stale
- **Package:** `com.pinflow.*` (НЕ `com.pinterest.automator.*`)
- **APK собран 13:42 Jun 28** (содержит CSRF fix, ещё не пересобран после коммита — но коммит = same content): `/root/pinflow_scp/app/build/outputs/apk/debug/app-debug.apk` (8.6MB)

## CSRF fix state (вечер 2026-06-28)
- **Закоммичен на server**: `5be1a33` включает CookieHelper.kt (новый, 92 строки), AuthActivity.kt, PostSettingsActivity.kt, activity_main.xml (10 строк пустых MaterialButton удалены)
- **APK скачан в Termux**: `~/downloads/pinflow-csrf-fix.apk` (8653322 bytes, 8.6MB)
- **НЕ доставлен на устройство**: /sdcard/Download/ недоступен в Termux без `termux-setup-storage` opt-in
- **НЕ протестирован пользователем**: ждём логин через `ru.pinterest.com` → «Загрузить доски» → должен показать список досок

## Что осталось (next session)
1. Пользователь забирает `~/downloads/pinflow-csrf-fix.apk` через файловый менеджер Termux ИЛИ запускает `termux-setup-storage` для авто-доставки в /sdcard/Download/
2. Установка APK, логин через ru.pinterest.com, тест «Загрузить доски»
3. Синхронизация local↔server: local отстаёт на 3 коммита + имеет local-only MainActivity/XML — нужен merge план (включить local-only в новый коммит ИЛИ перетереть local pull'ом)
4. Push `5be1a33` на GitHub origin/master (если ещё не запушен)

**Why:** CSRF fix существует как коммит + APK, но не дошёл до устройства и не протестирован. Local репа расходится с server — простого pull недостаточно из-за local-only правок MainActivity/XML.

**How to apply:**
- Если юзер жалуется «доски не грузятся» после установки — спросить путь логина (ru.pinterest.com или www) и проверить лог `CookieHelper → csrftoken present/MISSING`
- Если csrftoken MISSING — расширить список доменов в `CookieHelper.domains`
- Если API 200 но 0 досок — bc653fe сломал `findBoardsFromJson`, отдельный заход
- Перед следующей сборкой: сверить `local.properties=sdk.dir=/opt/android-sdk`, сделать `git pull` на local после merge local-only правок
