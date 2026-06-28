---
name: PinFlow package path — com.pinflow, not com.pinterest.automator
description: When grep'ing PinFlow Android sources, use package `com.pinflow/...`, NOT `com.pinterest.automator/...`
type: reference
---

В PinFlow Android проекте актуальный package = `com.pinflow` (не `com.pinterest.automator`). Activities:
- `com.pinflow.ui.PostSettingsActivity` (`app/src/main/java/com/pinflow/ui/PostSettingsActivity.kt`)
- `com.pinflow.automator.PinterestAutomator` (`app/src/main/java/com/pinflow/automator/PinterestAutomator.kt`)
- `com.pinflow.automator.PostQueueManager`
- `com.pinflow.data.Account`
- `com.pinflow.utils.SessionManager`, `com.pinflow.utils.FileLogger`, `com.pinflow.utils.LogManager`

**Why:** 2026-06-28 я grep'нул `com/pinterest/automator/ui/PostSettingsActivity.kt` — получил No such file or directory. Реальное имя — `com/pinflow/`. Старое имя из ранних коммитов / другой ветки.

**How to apply:** При диагностике PinFlow:
- grep с `com/pinflow/` (не `com/pinterest/...`)
- Если нужен layout XML ID — ищите в `app/src/main/res/layout/`
- Если нужно сверить `R.id.loadBoardsButton` — ищите `findViewById<MaterialButton>(R.id.loadBoardsButton)` в `PostSettingsActivity.kt`
- Файл может быть как `activity_post_settings.xml`, так и в `layout/` root, проверять `ls app/src/main/res/layout/`
