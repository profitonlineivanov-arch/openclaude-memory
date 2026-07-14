---
name: Memory sync conflict markers fix
description: MEMORY.md получил merge-conflict маркеры от sync; чистка + push в origin/main решает (2026-07-14)
type: project
---

MEMORY.md в memory-repo (profitonlineivanov-arch/openclaude-memory) получил 15 git merge-conflict маркеров (`<<<<<<<`/`=======`/`>>>>>>>`) — 3 конфликтных региона, дублирующиеся .md ссылки с разными описаниями.

**Why:** cross-device sync (hook-based handoff через GitHub) иногда создаёт конфликты которые автоматически не разрешаются.

**How to apply:**
- Чистка: разрешить по каноничному контенту реальных .md файлов (читать frontmatter `name`/`description`), не по описаниям в индексе.
- Git repo: `C:\Users\Admin\.openclaude\projects\C--Users-Admin\memory`, remote origin = profitonlineivanov-arch/openclaude-memory.git, branch main.
- **Pre-commit/sync hook auto-коммитит "Memory update: ..." и сбрасывает staging** — поэтому `git add` нескольких файлов + один commit не сработает как ожидается; нужны отдельные commit'ы под конкретные файлы, или staging сразу перед commit без паузы.
- Push обязателен: origin с маркерами → при следующем sync с другого устройства конфликт вернётся. Проверять `git show origin/main:MEMORY.md | grep -cE "^(<<<<<<<|=======|>>>>>>>)"` = 0.
- `_handoff_pending.md` — handoff-временный артефакт, не коммитить (sync сам управляет).

Фикс 2026-07-14: 3 commit (af0af90, 17be2f4, fffe268) запушены, origin чист.
