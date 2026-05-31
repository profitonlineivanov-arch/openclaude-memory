---
name: Draw Interval Polling
description: Draws появляются каждые ~15 минут, polling должен быть не чаще 5 минут
type: feedback
---

Polling interval для мониторинга новых тиражей должен быть ~5 минут (300с), не 60с.

**Why:** Draws появляются с интервалом ~15 минут (иногда больше). Polling каждые 60с — чрезмерно частый, бесполезная нагрузка.

**How to apply:** При создании скриптов с polling (monitoring, feedback loops) для лотерейных тиражей — используй интервал 300с (5 мин), не 60с.
