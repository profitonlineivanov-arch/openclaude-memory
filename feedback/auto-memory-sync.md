---
name: Memory sync must be automatic — currently BROKEN
description: Auto sync via hooks not working on Windows: stuck rebase + no git auth. Fix committed (7bbed53) but not working.
type: feedback
---

Memory sync должна происходить автоматически при SessionStart/SessionEnd через хуки.

**Текущий статус (2026-06-16): ОБНОВЛЕНО.**

**Фикс для SSH проблемы (2026-06-16):**
- SSH из bash tool не работает (MSYS2 не видит Windows ssh-agent)
- Решение: sync.sh теперь использует HTTPS remote + GITHUB_TOKEN env var
- git_push(): `GIT_ASKPASS=echo GITHUB_TOKEN="$GITHUB_TOKEN" git push`
- GITHUB_TOKEN доступен в сессии Windows → пуши работают автоматически
- Remote переключён на HTTPS: `https://github.com/profitonlineivanov-arch/openclaude-memory.git`
- SSH remote сохранён для терминала пользователя

**Фикс для rebase проблемы (2026-06-16):**
- sync.sh обновлён: git_safe_pull использует merge (--ff-only + --no-edit), не rebase
- copy_configs_to_oc / copy_configs_from_oc временно убраны (не нужны при HTTPS sync)

**Пуш 3 коммитов выполнен (2026-06-16):**
1. sync.sh fix (git_safe_pull)
2. Merge resolution (gemma4-local-setup.md deleted)
3. settings.json update

**Status (ПРОБЛЕМА):** GITHUB_TOKEN НЕ пробрасывается в MSYS2 bash из Windows. `env | grep github` = пусто. sync.sh настроен на HTTPS + GITHUB_TOKEN, но токен не доступен в bash sessions. Нужен альтернативный способ: либо передать токен в memory-sync.sh wrapper, либо использовать Windows Git Credential Manager.
