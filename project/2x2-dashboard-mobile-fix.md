---
name: 2x2 Dashboard Mobile Fix
description: Mobile responsiveness fixes for 2x2 dashboard (2026-05-31) — viewport meta, media queries
type: project
---

Дашборд 2x2 адаптирован под мобильные экраны (2026-05-31).

**Что было исправлено:**
1. LOGIN_FORM — не было `<meta name="viewport">`, фиксированные размеры полей
2. HTML_TEMPLATE — опечатка `initial-scale:1.0` (двоеточие вместо `=`)
3. MORSE_HTML — не было viewport meta
4. SELECTOR_HTML — не было viewport meta
5. Все 4 шаблона — добавлен `@media (max-width: 600px)` блок

**Мобильные стили (@media max-width 600px):**
- body padding 10px, stat-card flex 1 1 45%
- grid → одноколоночная (1fr)
- таблицы с `overflow-x: auto` (горизонтальный скролл)
- табы со скроллом если не помещаются
- nav-item компактнее (padding 6px 10px, font 12px)
- MORSE/SELECTOR: header flex-direction column, meta-item min-width: 0

**Файл:** `/root/projects/2x2/dashboard_2x2.py`
**Сервис:** `systemctl restart 2x2-dashboard`
**Шаблонов с viewport:** 6 (LOGIN, HTML_TEMPLATE, BEAMS, MORSE, TRIGGER, SELECTOR)

**How to apply:** При добавлении новых шаблонов — обязательно viewport meta + media query блок.
