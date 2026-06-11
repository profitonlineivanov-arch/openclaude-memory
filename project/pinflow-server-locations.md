---
name: PinFlow Server Locations
description: Проект в /root/pinflow_scp/ (не /pinflow/!), SDK в /opt/android-sdk/, local.properties=sdk.dir=/opt/android-sdk
type: project
---

**Актуальный проект:** `/root/pinflow_scp/` (проверено 2026-06-11)
- Полная структура проекта на верхнем уровне: `app/`, `build.gradle`, `gradlew`, `settings.gradle`, `local.properties`, `gradle.properties`
- **НЕ git-репо** — нет `.git/` (подтверждено 2026-06-11: `fatal: not a git repository`). Код заливается через SCP отдельных файлов, сборка через `./gradlew assembleDebug` прямо в этом каталоге. `git pull` на сервере НЕ работает.
- Также есть подкаталог `/root/pinflow_scp/pinflow/` — может содержать старую копию, не использовать для сборки.

**SDK:** `/opt/android-sdk/` (НЕ `/root/Android/Sdk/`)
- build-tools/34.0.0, platforms/android-34, cmdline-tools/latest
- `local.properties` ДОЛЖЕН содержать `sdk.dir=/opt/android-sdk`
- AAPT2: `/opt/android-sdk/build-tools/34.0.0/aapt2` (x86-64 ELF)

**Сборка:** `cd /root/pinflow_scp && ./gradlew assembleDebug --no-daemon`
**APK output:** `/root/pinflow_scp/app/build/outputs/apk/debug/app-debug.apk`

**gradle.properties:** локальная версия — авторитетная. На сервере были лишние строки `android.aapt2FromMavenOverride=false` и `android.enableBuildScriptAapt2FromMaven=false` — ломают AAPT2. Перед сборкой сверять серверный gradle.properties с локальным.
