---
name: gh device flow in Termux
description: gh auth login запускает device flow (не браузер) в Termux — нужно передать одноразовый код пользователю
type: feedback
---

`gh auth login --hostname github.com --git-protocol ssh --skip-ssh-key` в Termux запускает device flow: выдаёт одноразовый код (например, `3112-B3ED`) и URL `https://github.com/login/device`.

**Why:** 2026-06-06 — попытка аутентифицировать gh для доступа к GitHub Actions логам PinFlow. `gh auth login` не открывает браузер в Termux (без GUI), а использует device flow. Код нужно показать пользователю, чтобы он ввёл его в браузере на телефоне. Без таймаута команда ждёт вечно.

**How to apply:** Запустить `gh auth login --hostname github.com --git-protocol ssh --skip-ssh-key`, дождаться появления кода, показать пользователю, затем запустить `gh auth status` для проверки. Использовать `timeout 10` если нужен только код (команда упадёт по таймауту, но код уже выведен).
