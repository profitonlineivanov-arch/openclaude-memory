---
name: PinFlow board settings UI
description: UI updates for board selection in PostSettingsActivity (2026-06-11)
type: project
---

**Факт:** В `activity_post_settings.xml` обновлен ввод досок для постинга.
- Удалены примеры "Доска 1, Доска 2, Доска 3" из `android:hint`.
- Текст `app:helperText` изменен с "Названия досок через запятую" на "Укажите доску для постинга".

**Why:** Убрать лишний визуальный шум и сделать инструкцию более прямой.

**How to apply:** При обновлении настроек постинга придерживаться лаконичных инструкций без примеров-заглушек в хинтах.
