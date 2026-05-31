---
name: JS falsy zero in parameter defaults
description: `param = param || default` fails when param=0 (falsy) — use explicit undefined check instead
type: feedback
---

In JavaScript, `limit = limit || 50` treats `0` as falsy, so `limit=0` becomes `50`. Use `if (limit === undefined || limit === null) limit = 50` instead.

**Why:** Found this bug in 2x2 dashboard `renderACQualityStats()` — the "All" button (data-limit="0") silently sent limit=50 to the API, making the button appear broken.

**How to apply:** Any time you write a JS default parameter pattern with `||`, check whether 0 or "" are valid inputs. If they are, use explicit null/undefined check.
