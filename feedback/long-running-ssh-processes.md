---
name: Long-running SSH processes
description: Long computations on remote server must use nohup + python3 -u, not inline SSH — connections drop after ~10 min
type: feedback
---

Длительные скрипты на сервере запускать через `nohup` в фоне, а не inline SSH.

**Why:** SSH-соединение рвётся через ~10 минут ("Software caused connection abort", "Broken pipe"). Inline `ssh root@... "python3 script.py"` теряет результат. Также Python буферизует stdout при redirect в файл — нужно `python3 -u`.

**How to apply:**
1. Скрипт SCP на сервер: `scp script.py root@45.146.164.144:/tmp/`
2. Запуск в фоне: `ssh root@... "cd /root/projects/2x2 && source /root/venvs/2x2/bin/activate && nohup python3 -u /tmp/script.py > /tmp/output.txt 2>&1 &"`
3. Проверка прогресса: `ssh root@... "tail -5 /tmp/output.txt"` и `ps aux | grep script`
4. Убивать сиротские процессы перед повторным запуском: `kill PID` — после broken pipe остаются zombie-процессы
5. Monitor tool использовать только для polling с большой паузой (60+ сек), не для ожидания завершения — он тоже рвётся
