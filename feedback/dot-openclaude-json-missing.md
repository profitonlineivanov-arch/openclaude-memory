---
name: .openclaude.json missing breaks /provider
description: `/provider` зависает/показывает урезанный список → проверить .openclaude.json. Recovery: backups/ ИЛИ configs/ в memory-репо.
type: feedback
---

**Симптом 1:** `/provider` показывает `Topsy-turvying… (30s)` + рекламный tip.
**Причина:** `.openclaude.json` отсутствует.
**Fix:** восстановить из `backups/` ИЛИ из `configs/` memory-репо.

**Симптом 2:** `/provider` работает, но показывает только 1 провайдера вместо 4.
**Причина:** `.openclaude.json` существует, но свежий (firstStartTime = сегодня). Старый конфиг заменён.
**Fix:** проверить `configs/` в memory-репо — другая машина могла запушить полный конфиг. `cp configs/.openclaude.json ~/.openclaude.json`.

**Симптом 3:** `sync.sh pull` подтянул `configs/` из GitHub, но провайдеры не появились.
**Причина:** `copy_configs_to_oc` молча провалился — файл заблокирован процессом OpenClaude.
**Fix:** ручной `cp` из `configs/`.

**Why:** `.openclaude.json` хранит `providerProfiles`. Без него `/provider` падает. Бэкапы могут быть бесполезны если созданы после замены. `configs/` в GitHub-репо — дополнительный путь восстановления.
**How to apply:** При проблемах с `/provider` — проверить ВСЕ три источника: текущий файл, бэкапы, configs/ в memory-репо.
