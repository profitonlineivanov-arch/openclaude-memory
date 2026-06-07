---
name: .openclaude.json missing breaks /provider
description: Если /provider зависает на 30с с "Topsy-turvying" и рекламным tip-ом — проверить наличие .openclaude.json
type: feedback
---

Если `/provider` показывает `Topsy-turvying… (30s)` и рекламный tip (например, Xiaomi MiMo), вместо списка провайдеров — значит файл `.openclaude/.openclaude.json` отсутствует или был удалён.

**Why:** `.openclaude.json` хранит массив `providerProfiles` со всеми сконфигурированными провайдерами. Без него `/provider` не может ничего показать и уходит в таймаут. `.openclaude-profile.json` содержит только текущий активный профиль и не помогает.

**How to apply:** При жалобах на `/provider` — первым делом проверить `ls .openclaude/.openclaude.json`. Если файла нет — восстановить из `ls -t .openclaude/backups/` и перезапустить OpenClaude. Не пытаться чинить API или сеть — проблема локальная.
