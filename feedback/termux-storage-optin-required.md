---
name: Termux shared-storage paths require opt-in
description: `/storage/downloads`, `/storage/shared`, `/home/storage/*` в Termux видны только после `termux-setup-storage`. Не угадывать пути.
type: feedback
---

В Termux paths `/data/data/com.termux/files/home/storage/downloads/`, `home/storage/shared/`, `home/storage/pictures/`, `home/storage/dcim/` доступны ТОЛЬКО после `termux-setup-storage` (интерактивный диалог с пользователем на устройстве). В стандартной headless Bash-сессии OpenClaude эти ссылки не существуют — `ls` возвращает ошибки.

**Why:** 2026-06-28 я попробовал `ls -la /data/data/com.termux/files/home/storage/downloads/` и `ls -la /data/data/com.termux/files/home/storage/shared/` параллельно — обе вернули "No such file or directory" → пользователь отменил обе команды подряд. Третье прерывание "и что?" = признак фрустрации.

**How to apply:**
- В Termux NEVER делать `ls /home/storage/*`, `ls /storage/*` без уверенности что opt-in пройден
- Если пользователь явно говорит "логи скачаны в Downloads" — спросить разово: "у тебя termux-setup-storage уже сделан? Если нет, скажи путь на устройстве (например, /sdcard/Download/...)" — ОДИН вопрос
- Не делать speculative sweeps по `/sdcard`, `/storage`, `/home/storage` директориям параллельно — это трата токенов и провоцирует interrupt storm
- Reliable data path в Termux = `~/downloads/` (Termux home Downloads, не shared) — но пользователь должен положить файл туда сам через `cp` или shared scp
