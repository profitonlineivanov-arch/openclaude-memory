---
name: Selector Iteration Reverse Engineering (superseded)
description: SUPERSEDED by project/selector-iteration-reverse-engineering.md — kept for schema/command reference
type: project
---

# SUPERSEDED — see `project/selector-iteration-reverse-engineering.md`

This file is kept for historical reference (schema, dependencies). Current status is in the project/ version.

## Schema изменения
Добавлены колонки в `predictions_v4`:
```sql
ALTER TABLE predictions_v4 ADD COLUMN iter_match1 INTEGER;
ALTER TABLE predictions_v4 ADD COLUMN iter_match2 INTEGER;
ALTER TABLE predictions_v4 ADD COLUMN iter_match3 INTEGER;
ALTER TABLE predictions_v4 ADD COLUMN iter_match4 INTEGER;
```

## DEPENDENCIES
- tqdm (установлена 2026-06-07)
- yaml, sqlite3, horizontal_selector_v4, rarity_index
