---
name: 2x2 Trigger Logic
description: Current implementation of trigger patterns for 2x2 lottery positions
type: project
---

Triggers are split into three systems: Horizontal, Diagonal, and Vertical. For each target position, trigger patterns are used to find matches in history and identify anti-candidates (AC).

**1. Horizontal Triggers (trigger_analyzer.py):**
Defined as triples of numbers within a single draw.
- Target P1: Trigger = [P4, P1, P2]
- Target P2: Trigger = [P1, P2, P3]
- Target P3: Trigger = [P2, P3, P4]
- Target P4: Trigger = [P3, P4, P1]

**2. Diagonal Triggers (diagonal_trigger_analyzer.py):**
Defined as triples of numbers across 3 consecutive draws, shifting positions per draw.
- **Right Diagonal (diag_right):** Starts from right neighbor, shifts +1 position per draw back.
- **Left Diagonal (diag_left):** Starts from left neighbor, shifts -1 position per draw back.

**3. Vertical Triggers (vertical_trigger_analyzer.py):**
Defined as triples of numbers in the same target position across 3 consecutive draws.
- **Mechanism:** Trigger = [Pos X (current), Pos X (t-1), Pos X (t-2)].
- **Result:** AC is the number at Pos X in the draw immediately following the match.

**Mechanism:**
1. Extract trigger (horizontal triple or diagonal chain) from current state.
2. Find matching pattern in history.
3. The number at the target position in the draw immediately following the match is the AC.

**Why:** Combined approach to catch both static and shifting patterns.
**How to apply:** Use these mappings when analyzing or modifying `trigger_analyzer.py`, `diagonal_trigger_analyzer.py`, or updating dashboard visualizations.
