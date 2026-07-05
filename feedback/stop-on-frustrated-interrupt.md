---
name: Stop exploratory storage sweeps on frustrated interrupt
description: When user interrupts with «и что?»/«как процесс?», immediately halt optional storage sweeps (find /sdcard, ls /storage/*) and either pivot to server-side data or ask for one specific artifact.
type: feedback
---

Когда пользователь прерывает мою работу interrupt'ом («и что?», «как процесс?», «раньше все работало», или просто отменяет Bash-tool без сообщения) — это сигнал что я копаю не там где нужно.

Симптомы из 2026-06-28 PinFlow board-loader сессии:
- Я начал делать `find /sdcard -maxdepth 4 ...`, `ls /sdcard/Download/pinflow_logs/...` — обе провалились (No such file or directory), потому что `/sdcard` не маппится в Termux без opt-in
- Вместо остановки я сделал ещё две попытки `ls /data/data/.../storage/downloads` и `ls /storage/shared` — обе отменены пользователем
- Третий interrupt с «и что?» = фрустрация от пустых попыток

**Rules:**
- После первого interrupt'а или явного «и что?» — ОСТАНОВИТЬ всю optional search-активность в файловой системе
- Не делать `find /sdcard`, `ls /storage/*`, `ls /home/storage/*`, `cat /data/data/...` без явного подтверждения
- Pivot immediately на источники которые работают: SSH на сервер 45.146.164.144, git log, GitHub master, memory

**Why:** 2026-06-28, две отмены моих ls/find-команд подряд. Третий interrupt привёл к потере контекста и переходу на ручную диагностику с пользователем. Memory уже есть про `/storage` opt-in (`termux-storage-optin-required.md`) и «сам ищи» (`user-says-find-yourself.md`) — но rule не покрывал случай когда interrupt приходит БЕЗ отмены команды, а просто с коротким сообщением.

**How to apply:**
- Увидел interrupt или короткое недовольное сообщение → СТОП весь file-sweep
- Перечитать memory на предмет «какой источник доступен прямо сейчас»
- Спросить пользователя ОДИН конкретный артефакт с конкретным путём куда положить (не список догадок)
- Не пытаться «починить» тем что попробую ещё одну команду — это эскалация, не решение
