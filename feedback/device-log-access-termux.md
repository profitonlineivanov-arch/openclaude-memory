---
name: Device log access — Termux has no auto-path to phone logs
description: Termux cannot auto-fetch Android device logs or APKs without adb; storage/* requires user authorization. Don't ask to dig — say what is needed.
type: feedback
---

Когда нужны логи/APK с устройства пользователя, в Termux нет автоматического пути:
- `adb` отсутствует (`bash: line 1: adb: command not found`)
- `/sdcard/Download/...` недоступен напрямую (нужны `/storage/...` shared storage paths, которые Termux не открывает без явного вызова `termux-setup-storage` + пользовательского подтверждения)
- `find /sdcard ...` возвращает пустой результат в стандартной Bash-сессии Termux

**Why:** 2026-06-28 диагностика "доски не грузятся" в PinFlow PostSettings — я попросил пользователя прислать логи и имя APK, получил ответ «сам ищи» + пользователь отменил 2 моих попытки перебрать `/data/data/com.termux/files/home/storage/downloads/` и `/storage/shared/`. Эти пути требуют opt-in через termux-setup-storage, в стандартной сессии не появляются.

**How to apply:** Когда нужен реальный data с Android-устройства (логи FileLogger, APK файл, скриншот, logcat), не просить пользователя "скинь лог" сразу. Сначала проверить что доступно через SSH к серверу (`ssh root@45.146.164.144 "cat /root/pinflow_logs/..."` если пайплайн пишет туда) или через MemoryRemoteTools. Если ничего не доступно, явно перечислить что требуется от пользователя И предложить конкретные команды, которые он должен запустить на устройстве. Не пытаться угадывать пути `/sdcard/...` или `/storage/...` — Termux их не видит без явного разрешения.
