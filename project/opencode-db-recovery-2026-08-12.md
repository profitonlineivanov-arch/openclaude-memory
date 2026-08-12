---
name: opencode broken DB recovery
description: opencode не запускается — битая БД __drizzle_migrations. Сессии найдены в gigatool БД. Восстановление прервано EBUSY, ждём ребут
type: project
---

# opencode DB recovery — IN PROGRESS (2026-08-12)

## Суть проблемы
- opencode падает: `Error: malformed database schema (__drizzle_migrations) - invalid rootpage (11)`
- Дефолтная БД `~/.local/share/opencode/opencode.db` (1.6MB) — БИТАЯ
- 152 сессии найдены в здоровой БД `~/.local/share/gigatool/opencode.db` (4.0GB, integrity OK)
- GigaTool = "MultiTool" — вероятно альтернативный layout данных после установки

## Что сделано
1. postinstall вручную: `cd /c/Users/Admin/AppData/Roaming/npm/node_modules/opencode-ai && node postinstall.mjs` → opencode запустился (1.18.11)
2. Бэкап 4GB gigatool БД → `/c/Users/Admin/opencode-gigatool-backup.db` (4273143808 байт, НА МЕСТЕ)
3. Попытка `npm i -g opencode-ai@latest` → EBUSY (файл занят)
4. Пользователь решил ребутнуть комп для освобождения блокировки

## План ПОСЛЕ ребута
1. `npm i -g opencode-ai@latest` (EBUSY должен уйти)
2. `cp /c/Users/Admin/.local/share/gigatool/opencode.db /c/Users/Admin/.local/share/opencode/opencode.db`
   (заменить битую 1.6MB БД на здоровую 4GB)
3. `rm -rf /c/Users/Admin/.local/share/gigatool/opencode/` (побочная пустая subdir 4KB)
4. `opencode` → проверить что 152 сессии видны
5. Подтвердить пользователю

## Нюанс
- `XDG_DATA_HOME` создаёт subdir `opencode/opencode.db` ВНУТРИ XDG, не использует gigatool/opencode.db напрямую
- Решение: НЕ XDG, а перенос БД в дефолтный путь
- Если opencode после переустановки всё равно падает на malformed schema → удалить битую БД, скопировать gigatool на её место

## Файлы
- `/c/Users/Admin/.local/share/opencode/opencode.db` — битая 1.6MB, ЗАМЕНИТЬ
- `/c/Users/Admin/.local/share/gigatool/opencode.db` — здоровая 4GB, 152 сессии, ИСТОЧНИК
- `/c/Users/Admin/opencode-gigatool-backup.db` — бэкап 4GB, НЕ ТРОГАТЬ до подтверждения
- `/c/Users/Admin/.local/share/gigatool/opencode/opencode.db` — побочная пустая 4KB, УДАЛИТЬ

## Версии
- opencode-ai: 1.18.11 (после ручного postinstall)
- `/c/Users/Admin/.config/opencode/package.json` → `@opencode-ai/plugin` 1.17.9
- `/c/Users/Admin/.opencode/package.json` → `@opencode-ai/plugin` 1.17.18
