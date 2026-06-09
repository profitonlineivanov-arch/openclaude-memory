---
name: pinflow-local-workflow
description: PinFlow — работать локально, на сервер только для сборки, на GitHub для хранения. Сервер — не хранилище.
type: feedback
---

PinFlow: все изменения делаем в локальном ~/pinflow/. На сервер отправляем только для сборки APK (gradlew assembleDebug). После сборки — забираем APK, серверные файлы чистим. GitHub — основное хранилище кода.

**Why:** На сервере дефицит места. Актуальный код должен быть в одном месте — локально + GitHub. Сервер — ephemeral build environment.

**How to apply:**
- Работа: edit → build (scp на сервер → gradlew) → забрать APK → почистить сервер
- Сохранение: git commit + git push на GitHub
- CodeGraph индекс обновляется автоматически при локальных изменениях
- Не хранить копии проекта на сервере между сессиями
