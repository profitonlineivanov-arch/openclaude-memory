---
name: 2x2 Selector Fix Type Labels (Russian)
description: fix_type values on selector page shown in Russian — Перестановка цифр, Смена позиций, Пропуск по RI (2026-06-30)
type: project
---

На странице селектора (SELECTOR_HTML в dashboard_2x2.py) `fix_type` отображается на русском языке вместо английских кодов.

Маппинг:
- `swap` → "Перестановка цифр"
- `change_position` → "Смена позиций"  
- `ri_skip` → "Пропуск по RI"
- `null` / без fix_type → "—" (оригинальный fallback)

Реализовано через JS-объект `fixLabels` в renderMeta().
