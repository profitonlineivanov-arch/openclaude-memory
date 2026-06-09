---
name: selector-iteration-requirement-clarification
description: User's exact requirements for selector iteration reverse engineering task
type: project
---

**Exact Task Specification (2026-06-08):**

User wants reverse-engineering analysis on 2x2 lottery system:
1. **Depth:** 10,000 historical draws (not 1000, not 50)
2. **Method:** For EACH of the 10,000 draws, restart the selector multiple times
3. **Tracking:** For each draw, record on which iteration (restart) the selector first achieved:
   - 1 match with actual draw numbers
   - 2 matches
   - 3 matches
   - 4 matches
4. **Output:** Store all results in database
5. **Process:** Study documentation first → propose plan for user approval → THEN execute

**Why this matters:** Partial execution, wrong parameters, or skipping documentation review causes frustration and wasted work.

**How to apply:** 
- Before ANY selector iteration analysis, confirm depth=10000 draws
- Confirm max_runs parameter needs to be large enough to capture all match levels
- Review horizontal_selector_v4.py, rarity_index.py, anti_candidates_history schema FIRST
- Create detailed plan with specific parameters → get user approval → only then run