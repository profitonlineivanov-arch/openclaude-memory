---
name: Dashboard 4x20 Restored
description: Восстановлен дашборд 4x20 на порту 8080
type: project
originSessionId: 9864dd2a-01a6-496d-8145-6ee158f78fd7
---
## Задача выполнена: 2026-04-16

**Проблема:** Дашборд 4x20 (порт 8080) не был запущен.

**Решение:** Запущен вручную:
```bash
nohup python3 /root/projects/4x20/dashboard.py > /root/projects/4x20/logs/dashboard.log 2>&1 &
```

**Примечание:** Виртуального окружения для 4x20 нет — запускается через системный python3 (Flask 3.0.2 установлен). Процесс поднялся с PID 4142341.

**Дашборд:** http://45.146.164.144:8080/
