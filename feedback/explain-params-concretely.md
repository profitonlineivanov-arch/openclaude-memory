---
name: Explain config params concretely
description: Explain parameters in concrete terms tied to user's actual data flow, not abstract descriptions
type: feedback
---

When explaining what a config parameter does, do NOT:
- Describe it in abstract/aggregate terms ("фильтр минимального числа прогнозов в час")
- Use made-up examples that don't match user's data volume ("1 прогноз в день на час")

Instead:
- Start with the concrete question it answers about user's data ("сколько раз ты сделал прогноз именно в этот час за всю историю")
- Explain what happens WITHOUT the parameter, then what it adds
- Connect to the visible output user sees (best_hours, banner)
- If a default is arbitrary, say so outright ("авторский дефолт, не основан на аналитике")

**Why:** User doesn't think in terms of abstract aggregation buckets ("per hour"). They think in terms of individual actions ("я делаю прогноз"). Abstract explanations confuse and frustrate.

**How to apply:** Before explaining any config parameter, ask yourself: "если я объясню это Владу так, поймёт ли он с первого раза, ЧТО это меняет в его данных?" If the answer is no, rewrite.
