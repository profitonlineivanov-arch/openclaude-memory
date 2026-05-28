---
name: Research on Remote Server
description: When working on production code — do research on the remote server (45.146.164.144), not local copies. Production code is authoritative.
type: feedback
---

Исследования production-кода проводить на удалённом сервере, а не на локальных копиях.

**Why:** Пользователь указал, что серверный код — авторитетный источник. Локальные копии (`C:\Users\admin\Downloads\`) могут отличаться от production. Пользователь явно сказал: "Тебе нужно произвести исследование на удаленном сервере, а не на локальном!"

**How to apply:** Для проектов 2x2 и 1224 — SSH на `root@45.146.164.144`, пути `/root/projects/2x2/` и `/root/projects/1224/`. Читать файлы через `ssh root@... "cat /path/to/file"`. Локальные копии использовать только для reference/документации, не для анализа текущего состояния кода.
