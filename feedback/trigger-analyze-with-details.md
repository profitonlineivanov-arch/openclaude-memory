---
name: Fix trigger AC count (2026-06-30)  
description: Driver called analyze() (first match only) instead of analyze_with_details() (all matches)
type: feedback
---

Правило: в driver_v5.py триггерные анализаторы вызывать через `analyze_with_details()`, не `analyze()`.

**Почему:** `analyze()` возвращает только первое совпадение на позицию (break/found_positions). `analyze_with_details()` возвращает все исторические совпадения. Иначе AC quality на дашборде показывает count=1 для всех триггерных анализаторов даже при большом history_size.

**Как применять:** driver_v5.py строки ~429-437: `ta.analyze_with_details(draws)`, итерация по `.get(pos, {}).get('acs', [])`. Фикс сделан 2026-06-30, все 6 замен + лог линия.
