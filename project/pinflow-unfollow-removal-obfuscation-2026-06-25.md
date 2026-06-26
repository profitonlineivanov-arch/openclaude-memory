---
name: PinFlow follow/unfollow removal + obfuscation phase
description: Follow/unfollow удалены из master, сохранены в ветке unfollow. Следующий этап — защита от reverse engineering (2026-06-25)
type: project
---

# PinFlow — Follow/Unfollow Removal + Obfuscation

**Дата:** 2026-06-25

## Удаление follow/unfollow из master

**Причина:** FollowingResource API заблокирован Pinterest (100% 403), followTime=0 persist, CSRF race. Функционал не работает — отложен на следующий этап.

### Удалённые файлы
- FollowSettingsActivity.kt
- UnfollowSettingsActivity.kt
- activity_follow_settings.xml
- activity_unfollow_settings.xml

### Изменённые файлы
- AndroidManifest.xml — удалены 2 activity declaration
- Account.kt — удалены поля: autoFollow, autoUnfollow, maxFollowsPerDay, maxUnfollowsPerDay, followDelayMinSec, followDelayMaxSec, unfollowDelayMinSec, unfollowDelayMaxSec, unfollowDelayAfterFollowHours
- Task.kt — удалены FOLLOW, UNFOLLOW из TaskType enum
- ActionHistory.kt — удалены FOLLOW, UNFOLLOW из ActionType enum
- LogManager.kt — удалены UNFOLLOWED из LogType, unfollows из stats
- SessionManager.kt — удалены KEY_AUTO_FOLLOW, KEY_AUTO_UNFOLLOW, getAutoFollow(), getAutoUnfollow()
- PinterestWorker.kt — условие проверки автозадач упрощено
### Статус редакций (2026-06-26 COMPLETED)

**Все правки завершены и закоммичены (commit 741f895):**
- AndroidManifest.xml — удалены 2 activity declaration ✅
- Account.kt — 9 follow/unfollow полей удалены ✅
- Task.kt — FOLLOW, UNFOLLOW из TaskType enum ✅
- ActionHistory.kt — FOLLOW, UNFOLLOW из ActionType ✅
- LogManager.kt — UNFOLLOWED, unfollows stats ✅
- SessionManager.kt — KEY_AUTO_*, get*() ✅
- PinterestWorker.kt — условие упрощено на `!account.autoPost && !account.autoLike` ✅
- PinterestAutomator.kt — removed: executeFollowTask, executeUnfollowTask, followUser, unfollowUser, getFollowingUsers (lines 695-874), collectFollowTimes, findFollowingInJson, extractJsonFromHtml, UserDataWithFollowerStatus, followedUsers, saveFollowedUsers ✅
- MainActivity.kt — all follow/unfollow UI refs removed ✅
- activity_main.xml — statsFollows, statsUnfollows, switches, buttons removed ✅
- strings.xml — follow/unfollow strings removed ✅
- 4 activity/layout файла удалены ✅
- `grep -rn` verification: zero follow/unfollow references remaining ✅

**Total:** 15 files changed, -1188 lines

### Ветка unfollow
Создана от коммита 073c1e6 (R7 fixes). Содержит полный код follow/unfollow для будущей разработки.

## Следующий этап — Obfuscation

**Цель:** Защитить приложение от reverse engineering, от копирования скриптов.

**Почему:** PinFlow — коммерческий автоматизатор, защита от декомпиляции и копирования логики критична.

**Git state:**
- master: R7 commit (073c1e6) + unfollow removal commit (741f895, -1188 lines), ahead of origin/master
- unfollow: branch from 073c1e6 with full follow/unfollow code
- Both need push to GitHub origin

**Build status:** FAILED — activity_main.xml:373 has broken SwitchMaterial tag (Python script line-by-line removal corrupted XML structure). Needs fix before APK can build.
