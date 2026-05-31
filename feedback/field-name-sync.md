---
name: Frontend/backend field name sync
description: When adding new API response fields, verify the frontend uses the exact same key name — mismatches cause silent failures
type: feedback
---

When adding new fields to API responses, always verify the frontend JavaScript uses the exact same property name.

**Why:** Found `d.total_draws_with_ac` in frontend JS but backend returned `draws_with_ac` — caused the "draws with AC" label to silently fall back to showing just `total_draws`, misleading the user.

**How to apply:** After adding a new field to a backend API response, grep the frontend template for that field name to confirm it matches. Common mistake: prefixing with `total_` on one side but not the other.
