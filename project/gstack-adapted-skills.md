---
name: gstack-inspired OpenClaude skills
description: User wants /review, /plan, /secaudit, /spec OpenClaude skills based on gstack workflow patterns
type: project
---

**Plan:** Create 4 OpenClaude plugin skills based on gstack (garrytan/gstack) concepts:

1. **`/review`** — code review checklist (completeness/correctness/security/maintainability), adapted from gstack `/review`
2. **`/plan`** — task planning with 6 forcing questions (from gstack `/office-hours`) + eng review checklist (from gstack `/plan-eng-review`)
3. **`/secaudit`** — security audit (OWASP Top 10 + STRIDE threat model), adapted from gstack `/cso`
4. **`/spec`** — vague intent → precise executable spec in phases, adapted from gstack `/spec`

**Status:** BLOCKED — GitHub/web access unavailable from Termux to fetch original SKILL.md content from gstack repo. Must write adapted versions from existing analysis/knowledge.

**Format:** Local OpenClaude plugin at `~/.openclaude/plugins/cache/local/gstack-skills/` with `skills/<name>/SKILL.md` structure. Register in `installed_plugins.json`.

**Why needed:** User asked "как я на практике буду использовать?" (how will I actually use this). Wants concrete slash commands, not abstract methodology.

**How to apply:** When resuming this task, write SKILL.md files from gstack concepts already analyzed — don't try WebFetch again. Practical examples required in each skill.
