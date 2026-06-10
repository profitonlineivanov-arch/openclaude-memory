---
name: PinFlow Board Loader — WORKING
description: Board loader РАБОТАЕТ. Dual-stage: BoardsResource + individual BoardResource/get/, 3 коммита на GitHub (2026-06-10).
type: project
---

**Статус (2026-06-10, 22:07): ЗАВЕРШЕНО И ЗАПУШЕНО + NEW BUG**

**Commits на GitHub master:**
- `9f08262` feat: dual-stage board loading with individual BoardResource fetch
- `6582e7a` chore: update board selector title ("Выберите доску для автопостинга")
- `a097047` chore: remove board manual input hint from PostSettings

**Подтверждено пользователем:** последняя редакция результативна. Запушена.

**NEW ISSUE (2026-06-10 22:02):** Автоматизация запускается, "Создание постов..." выводится, но дальше — тишина. Лог обрывается. possible causes: (1) images.isEmpty() → нет лога "Нет изображений", (2) завис на getPostImages() или createPin(), (3) onTaskComplete вызывается после первого поста и прекращает цикл. Нужны логи post-create и больше данных от пользователя.

**Why:** Pinterest API требует двухэтапной загрузки: список досок (node_id) + индивидуальный запрос для каждого имени (board_id через Base64 decode).