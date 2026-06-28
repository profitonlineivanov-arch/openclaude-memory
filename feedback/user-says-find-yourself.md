---
name: When user says "find it yourself" — investigate server-side before responding
description: User phrase "сам ищи" means: pivot to whatever data sources I can reach (server, commits, code), do NOT ask back for data the user can't easily export.
type: feedback
---

Когда пользователь говорит «сам ищи» (или эквивалент «сам разберись», «найди сам», «догадайся сам») в ответ на просьбу прислать лог/файл/APK с устройства — это значит:
1. Не продолжать просить дополнительные данные
2. Переключиться на источники, которые мне доступны:
   - git history (local + remote + GitHub master)
   - код на удалённом сервере (45.146.164.144)
   - FileLogger логи если они скопированы в `~/storage/downloads/` или `/root/pinflow_logs/` на сервере
   - commit messages и diff между версиями APK
3. Если всё равно нельзя диагностировать без device-side логов — честно сказать "нужен реальный лог-файл" с конкретным путём, куда пользователь должен его положить (например, `adb pull` или скопировать в `~/Downloads/` и сказать имя), но не задавать вопросов «а какой у вас APK» в формате догадок/вариантов

**Why:** 2026-06-28, PinFlow board loader: я попросил пользователя прислать кусок лога + имя APK. «сам ищи» = прямое указание pivot-а. В ответ я попробовал `find /sdcard -maxdepth 4 ...` и `ls /sdcard/Download/pinflow_logs/...` — обе команды вернули ошибки «No such file or directory». Это ожидаемо — `/sdcard` в Termux не маппится в стандартной сессии. Пользователь отменил 2 моих последующих команды `ls /data/data/.../storage/downloads` и `ls /.../storage/shared` — третий interrupt с сообщением «и что?» = фрустрация от того что я ковыряю закрома вместо диагностики.

**How to apply:** При «сам ищи»:
- Прекратить задавать вопросы об именах файлов/user state/log contents
- Проверить `git log` на local + server (есть ли commit с marker'ом изменений loader)
- Проверить FileLogger export path `adb pull /sdcard/Download/pinflow_logs/` — но только если adb есть (в Termux нет по умолчанию)
- Проверить remote сервер — возможно, лог уже синк-нут туда через scp
- Если ничего не доступно — стоп, написать «нужен [конкретный артефакт], положи сюда → [путь]», одна команда для пользователя, не список догадок
- НЕ делать наугад `find /sdcard`, `ls /storage`, `cat /data/data/...` — это пустые операции без opt-in storage permission
