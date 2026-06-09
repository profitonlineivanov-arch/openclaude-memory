---
name: pinflow-local-workflow
description: PinFlow — работать локально, на сервер только для сборки, на GitHub для хранения. Сервер — не хранилище.
type: feedback
---

PinFlow: все изменения делаем в локальном ~/pinflow/. На сервер отправляем только для сборки APK (gradlew assembleDebug). После сборки — забираем APK, серверные файлы чистим. GitHub — основное хранилище кода.

**Why:** На сервере дефицит места. Актуальный код должен быть в одном месте — локально + GitHub. Сервер — ephemeral build environment.

**How to apply:**
- Работа: edit локально → scp изменённые файлы на `/root/pinflow_scp/pinflow` → gradlew build на сервере → scp APK в `/sdcard/Download/`
- После scp/build проверять синхронизацию local vs remote по SHA256, если пользователь спрашивает
- Сохранение: git commit + git push на GitHub
- Если пользователь спрашивает «на GitHub залито?» — проверить git/remote status и ответить фактами. Не отказывать; это обычная проверка проекта. Push делать только по явной просьбе.
- CodeGraph индекс обновляется автоматически при локальных изменениях
- Не хранить копии проекта на сервере между сессиями
